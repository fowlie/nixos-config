{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    scrollbar = false;
    package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
}
