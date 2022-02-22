{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [{
      name = "foreign-env";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "plugin-foreign-env";
        rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
        sha256 = "1x1h65l8582p7h7w5986sc9vfd7b88a7hsi68dbikm090gz8nlxx";
      };
    }];
    shellAbbrs = {
      g      = "git";
      gs     = "git status";
      gd     = "git diff";
      gsw    = "git switch";
      d      = "docker";
      dc     = "docker-compose";
      copy   = "xclip -o -selection clipboard";
      hms    = "home-manager switch";
    };
    shellAliases = {
      ls     = "exa --icons --time-style long-iso --group-directories-first -lb";
      "..."  = "cd ../..";
      "...." = "cd ../../..";
    };
  };
}
