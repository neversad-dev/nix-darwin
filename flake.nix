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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
      username = "neversad";
      useremail = "neversad@null.computer";
      system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
      hostname = "vm-mac";

      pkgs = nixpkgs.legacyPackages.${system};

      specialArgs =
        inputs
        // {
          inherit username useremail hostname;
        };
  in
  {
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [ 
        ./modules/nix-core.nix
	      ./modules/system.nix
        ./modules/apps.nix
	      ./modules/host-users.nix
      ];
    };

    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = specialArgs;

      modules = [ ./home ];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
