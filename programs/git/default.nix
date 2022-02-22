{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    delta.enable = true;
    extraConfig = {
      merge.tool = "nvimdiff";
      push.default = "current";
    };
    aliases = {
      st = "status";
      pl = "pull";
      sw = "switch";
      co = "commit";
    };
  };
}
