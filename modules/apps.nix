{
  pkgs,
  lib,
  ...
}:
{
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    just

    telegram-desktop
    zed-editor
  ];

  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";
  environment.systemPath = lib.mkBefore [
    "/usr/local/bin" # intel mac
    "/opt/homebrew/bin" # m1 mac
    "/opt/homebrew/sbin"
  ];

  
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    taps = [
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };


    # `brew install`
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!

      "borders"
      "imagemagick"

      {
        name = "sketchybar";
        start_service = true;
        restart_service = "changed";
      }
    ];


    # `brew install --cask`
    casks = [
      "ghostty"
      "firefox"
      "google-chrome"
      "the-unarchiver"
      "alt-tab"
      "hiddenbar"
      "aerospace"
      "bettertouchtool"

      # messengers
      "viber"
      "signal"
      "zoom"

      "itsycal"
      "iina"
      "raycast" # (HotKey: alt/option + space)search, calculate and run scripts(with many plugins)
      "stats" # beautiful system status monitor in menu bar
      "monitorcontrol"

      "font-sf-pro"
      "sf-symbols"

      "android-platform-tools"
      "android-file-transfer"
      "localsend"
      "transnomino" # A batch rename utility for the Mac
      "handbrake" # Open-source video transcoder available for Linux, Mac, and Windows
      "imageoptim" # Tool to optimise images to a smaller size
      "onlyoffice" # Document editor
      "obsidian" # Knowledge base that works on top of a local folder of plain text Markdown files
      # "android-studio"
    ];


    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      Xcode = 497799835;
    #   wireguard = 1451685025;
      Bitwarden = 1352778147;
      PDFgear = 6469021132;
    };
  };
}
