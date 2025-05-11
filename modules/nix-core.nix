{
  ...
}:
{
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # Nix instance is managed via Determinate installation
  nix.enable = false;
}
