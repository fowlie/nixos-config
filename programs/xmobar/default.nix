{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.xmobar
  ];

  # config goes to ~/.config/xmobar/xmonad.hs
  xdg.configFile."xmobar/xmobarrc".source = ./xmobarrc;
}
