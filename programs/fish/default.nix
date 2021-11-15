{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [{
      name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "pure-fish";
        repo = "pure";
        rev = "v4.1.1";
        sha256 = "1x1h65l8582p7h7w5986sc9vfd7b88a7hsi68dbikm090gz8nlxx";
      };
    }];
    shellAliases = {
      gs   = "git status";
      gd   = "git diff";
      copy = "xclip -o -selection clipboard";
    };
  };
}
