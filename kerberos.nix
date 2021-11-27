{ config, pkgs, ... }:

{
  config.krb5 = {
    enable = true;
    config = ''
      [libdefaults]
        default_realm = VEGVESEN.NO
        rdns = false
    '';
  };
}
