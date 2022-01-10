{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "FiraCode Nerd Font 30";
    theme = "gruvbox-theme-soft";
  };
}
