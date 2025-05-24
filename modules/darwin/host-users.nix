{
  hostname,
  myvars,
  ...
}:
#############################################################
#
#  Host & Users configuration
#
#############################################################
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${myvars.username}" = {
    home = "/Users/${myvars.username}";
    description = myvars.username;
  };

  nix.settings.trusted-users = [myvars.username];
}
