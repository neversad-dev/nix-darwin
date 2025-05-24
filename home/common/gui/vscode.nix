{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = true;

    profiles.default.userSettings = {
      #  - all: Sends usage data, errors, and crash reports.
      #  - error: Sends general error telemetry and crash reports.
      #  - crash: Sends OS level crash reports.
      #  - off: Disables all product telemetry.
      "telemetry.telemetryLevel" = "off";
      "redhat.telemetry.enabled" = false;

      "diffEditor.ignoreTrimWhitespace" = false;

      "editor.detectIndentation" = true;
      "editor.fontFamily" = "FiraCode Nerd Font Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = false;
      "editor.inlineSuggest.enabled" = true;
      "editor.lineHeight" = 0;
      "editor.linkedEditing" = true;
      "editor.minimap.enabled" = false;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.snippetSuggestions" = "top";
      "editor.suggestSelection" = "first";
      "editor.tabSize" = 4;

      # we try to make semantic highlighting look good
      "editor.semanticHighlighting.enabled" = true;
      # prevent VSCode from modifying the terminal colors
      "terminal.integrated.minimumContrastRatio" = 1;
      # make the window's titlebar use the workbench colors
      "window.titleBarStyle" = "custom";

      "extensions.ignoreRecommendations" = true;

      "files.autoSave" = "onWindowChange";

      "git.autofetch" = true;
      "git.openRepositoryInParentFolders" = "never";

      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.editor.labelFormat" = "medium";
      "workbench.editor.showTabs" = "none";
      "workbench.iconTheme" = "catppuccin-mocha";
      # "workbench.sideBar.location" = "right";
      "workbench.startupEditor" = "newUntitledFile";
      # "workbench.statusBar.visible" = false;

      "editor.guides.highlightActiveIndentation" = false;

      # Using the light mode
      "indentRainbow.indicatorStyle" = "light";
      # we use a simple 1 pixel wide line
      "indentRainbow.lightIndicatorStyleLineWidth" = 1;
      # the same colors as above but more visible
      "indentRainbow.colors" = [
        "rgba(243, 139, 168, 0.3)" # #f38ba8
        "rgba(250, 181, 135, 0.3)" # #fab387
        "rgba(249, 226, 175, 0.3)" # #f9e2af
        "rgba(166, 227, 161, 0.3)" # #a6e3a1
        "rgba(137, 180, 250, 0.3)" # #89b4fa
        "rgba(203, 166, 247, 0.3)" # #cba6f7
      ];
      "editor.defaultFormatter" = "esbenp.prettier-vscode";

      "[markdown]" = {
        "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
      };

      "nix.enableLanguageServer" = true; # Enable LSP.
      "nix.serverPath" = "nixd"; # The path to the LSP server executable.
      "nixpkgs" = {
        #            "expr" = "import <nixpkgs> { }";
        "expr" = "import (builtins.getFlake \"/home/neversad/nix-darwin\").inputs.nixpkgs { }";
      };
      "options" = {
        "nixos" = {
          "expr" = "(builtins.getFlake \"/home/neversad/nix-darwin\").nixosConfigurations.CONFIGNAME.options";
        };
        "darwin" = {
          "expr" = "(builtins.getFlake \"/home/neversad/nix-darwin\").darwinConfigurations.CONFIGNAME.options";
        };
        "home_manager" = {
          "expr" = "(builtins.getFlake \"/home/neversad/nix-darwin\").homeConfigurations.CONFIGNAME.options";
        };
      };

      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
      };
      "alejandra.program" = "${pkgs.alejandra}/bin/alejandra";

      "[shellscript]" = {
        "editor.defaultFormatter" = "mkhl.shfmt";
      };
    };

    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # Code Fromatting and Quality
      esbenp.prettier-vscode # formatter
      oderwat.indent-rainbow

      # Development Tools
      christian-kohler.path-intellisense # Autocompletes filenames
      naumovs.color-highlight # Highlights color codes in your code
      gruntfuggly.todo-tree #  Shows TODO comments in a tree view

      # Markdown Support
      bierner.github-markdown-preview
      bierner.markdown-preview-github-styles
      bierner.markdown-emoji
      bierner.markdown-checkbox
      # bierner.markdown-yaml-preamble
      bierner.markdown-footnotes
      bierner.markdown-mermaid
      # bierner.markdown-image-size
      davidanson.vscode-markdownlint

      # Nix Support
      jeff-hykin.better-nix-syntax
      jnoortheen.nix-ide
      kamadorueda.alejandra

      # Language Support
      redhat.java # Java support
      mathiasfrohlich.kotlin # Kotlin support
      nefrob.vscode-just-syntax # Just syntax highlighting
      mads-hartmann.bash-ide-vscode # Bash IDE features
      timonwong.shellcheck # Shell script linting
      redhat.vscode-xml # XML support
      redhat.vscode-yaml # YAML support
      tamasfe.even-better-toml # TOML support
      mechatroner.rainbow-csv # CSV file support
      zainchen.json # JSON support
      irongeek.vscode-env # .env file support
    ];
  };
}
