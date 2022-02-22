
{ pkgs, ... }:

{
  home.packages = [
    pkgs.ranger
    pkgs.ueberzug
  ];

  xdg.configFile."ranger/rc.conf".source = ./rc.conf;
  xdg.configFile."ranger/colorschemes/dracula.py".source = ./dracula.py;
}
