{ pkgs, ... }:

{
  services.flameshot = {
    enable = true;

    # See https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
    settings = {
      General = {
        disabledTrayIcon = true;
        showHelp = false;
        showStartupLaunchMessage = false;
      };
    };
  };
}
