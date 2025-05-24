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
    darwinSystem = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
    linuxSystem = "aarch64-linux";
    hostname = "mbair";

    pkgs = nixpkgs.legacyPackages.${darwinSystem};
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
      inherit specialArgs;
      system = darwinSystem;
      modules = [
        ./modules/common/packages.nix
        ./modules/darwin
      ];
    };

    homeConfigurations."${myvars.username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = specialArgs // {inherit wallpapers inputs;};

      modules = [./home/darwin];
    };

    homeConfigurations."${myvars.username}@linux-vm" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${linuxSystem};
      extraSpecialArgs = specialArgs // {inherit wallpapers inputs;};

      modules = [./home/linux];
    };

    # nix code formatter
    formatter.${darwinSystem} = nixpkgs.legacyPackages.${darwinSystem}.alejandra;
    formatter.${linuxSystem} = nixpkgs.legacyPackages.${linuxSystem}.alejandra;
  };
}
