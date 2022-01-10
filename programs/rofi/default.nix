{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "FiraCode Nerd Font Medium 25";
    theme = let
      # Neccessary to avoid quoting non-string values
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      # Taken from https://github.com/Murzchnvok/rofi-collection/blob/master/gruvbox/gruvbox.rasi

      # Why does this configuration block not compile?
      "#configuration" = {
        font = "FiraCode Nerd Font 30";

#        drun = {
#          # ..it says display-name does not exist.
#          display-name = "";
#        };
#
#        run = {
#          display-name = "";
#        };
#
#        window = {
#          display-name = "";
#        };
#
#        timeout = {
#          delay = 10;
#          action = "kb-cancel";
#        };
      };

      "*" = {
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;

        bg = mkLiteral "#282828";
        bg-alt = mkLiteral "#3c3836";
        fg = mkLiteral "#fbf1c7";
        blue = mkLiteral "#83a598";

        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
      };


      "#window" = {
        transparency = "real";
      };

      "#mainbox" = {
        children =  mkLiteral "[inputbar, listview]";
      };

      "#inputbar" = {
        background-color = mkLiteral "@bg-alt";
        children =  mkLiteral "[prompt, entry]";
      };

      "#entry" = {
        background-color = mkLiteral "inherit";
        padding = mkLiteral "12px 3px";
      };

      "#prompt" = {
        background-color = mkLiteral "inherit";
        padding = mkLiteral "12px 16px 12px 12px";
      };

      "#listview" = {
        lines = 8;
      };

      "#element" = {
        children = mkLiteral "[element-text]";
      };

      "#element-text" = {
        padding = mkLiteral "10px";
      };

      "#element-text selected" = {
        text-color = mkLiteral "@blue";
      };
    };
  };
}
