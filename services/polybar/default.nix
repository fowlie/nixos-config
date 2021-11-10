{ pkgs, ... }:

let
  xmonad = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log

    tail = true
  '';
in
{
  services.polybar = {
    enable = true;
    config = ./config.ini;
    extraConfig = xmonad;
    script = ''
      polybar top&
    '';
  };
}
