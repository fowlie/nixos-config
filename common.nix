{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      LESS = "-j 5";
    };

    packages = with pkgs; [
      bottom
      gopls
      jo
      jq
      fx
      neofetch
      nodejs
      ripgrep
      tldr
    ];
  };
}
