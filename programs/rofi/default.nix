{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
}
