{
  lib,
  username,
  useremail,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;

    #     includes = [
    #       {
    #         # use diffrent email & name for work
    #         path = "~/work/.gitconfig";
    #         condition = "gitdir:~/work/";
    #       }
    #     ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      url = {
        "ssh://git@github.com/neversad-dev" = {
          insteadOf = "https://github.com/neversad-dev";
        };
      };

      # signing = {
      #   key = "xxx";
      #   signByDefault = true;
      # };

      delta = {
        enable = true;
        options = {
          side-by-side = true;
          navigate = true;
        };
      };
    };
  };
}
