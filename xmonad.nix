{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
}

