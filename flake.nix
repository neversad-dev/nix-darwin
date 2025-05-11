{
  description = "My basic nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, }:
  let
      username = "tinker";
      useremail = "tinker@null.computer";
      system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
      hostname = "vm-mac";

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

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
