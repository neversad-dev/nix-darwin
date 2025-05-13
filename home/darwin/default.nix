{ username, ... }:

{
  # import sub modules
  imports = [
    ../common/home.nix
    ../common/core
    ../common/tui
    ../common/gui

    ./aerospace
    ./sketchybar
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    homeDirectory = "/Users/${username}";
  };
}
