{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.dmenu
    pkgs.alacritty
  ];

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.xmonad-contrib
      ];
      config = ./config.hs;
    };
  };
}
