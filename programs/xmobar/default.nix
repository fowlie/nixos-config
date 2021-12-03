{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.xmobar
    pkgs.font-awesome
  ];

  xdg.configFile."xmobar/xmobarrc".source = ./xmobarrc;
  xdg.configFile."xmobar/itverket-logo.xpm".source = ./itverket-logo.xpm;
}
