{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono Retina";
    font.size = 12;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      include = "./theme.conf";
    };
  };

  xdg.configFile."kitty/theme.conf".source = ./gruvbox-dark.conf;
}
