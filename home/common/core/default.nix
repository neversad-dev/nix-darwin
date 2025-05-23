{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./shells
    ./autin.nix
    ./btop.nix
    ./catppuccin.nix
    ./core.nix
    ./dust.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./fzf.nix
    ./git.nix
    ./starship.nix
    ./zoxide.nix
  ];
}
