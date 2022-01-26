{ config, pkgs, ... }:

{
  home.sessionVariables = {
    LESS = "-j 5";
  };
}
