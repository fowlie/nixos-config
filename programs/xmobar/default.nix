{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.xmobar
  ];

  xdg.configFile."xmobar/xmobarrc".source = ./xmobarrc;
  xdg.configFile."xmobar/itverket-logo.xpm".source = ./itverket-logo.xpm;
}
