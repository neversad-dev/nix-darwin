{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    git
    just

    telegram-desktop
    zed-editor
  ];
}
