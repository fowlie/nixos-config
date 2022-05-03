{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
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
