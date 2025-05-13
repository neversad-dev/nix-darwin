{ config, pkgs, lib, wallpapers, ... }:

{
  home.file."Pictures/Wallpapers".source = "${wallpapers}";
}