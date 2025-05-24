{
  description = "My basic nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # theme
    catppuccin.url = "github:catppuccin/nix";
    catppuccin-vsc = {
      url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my wallpapers
    wallpapers = {
      url = "github:neversad-dev/wallpapers";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    wallpapers,
    ...
  }: let
    system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
    hostname = "mbair";

    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
    mylib = import ./lib {inherit lib;};
    myvars = import ./vars;

    specialArgs =
      inputs
      // {
        inherit myvars mylib hostname;
      };
  in {
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/common/packages.nix
        ./modules/darwin
      ];
    };

    homeConfigurations."${myvars.username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = specialArgs // {inherit wallpapers inputs;};

      modules = [./home/darwin];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
