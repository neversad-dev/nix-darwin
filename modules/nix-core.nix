{
  pkgs,
  ...
}:
{
  # Nix instance is managed via Determinate installation
  nix.enable = false;

  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };

  # enable rozetta must be installed with `softwareupdate --install-rosetta --agree-to-license`
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Install home manager but it is managed separately
  environment.systemPackages = [
    pkgs.home-manager
  ];

}
