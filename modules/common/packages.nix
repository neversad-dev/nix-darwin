{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    just
  ];
}
