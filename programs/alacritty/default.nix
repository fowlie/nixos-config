{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "FiraCode Nerdfont Mono";
        size = 12;
      };
      shell.program = "${pkgs.fish}/bin/fish";
    };
  };
}
