{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    delta.enable = true;
    aliases = {
      st = "status";
      pl = "pull";
      sw = "switch";
      co = "commit";
    };
  };
}
