{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerd Font Mono";
      };
      shell.program = "${pkgs.fish}/bin/fish";
    };
  };
}
