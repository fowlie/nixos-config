{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerd Font Mono";
        size = 12;
      };
      shell.program = "${pkgs.fish}/bin/fish";
    };
  };
}
