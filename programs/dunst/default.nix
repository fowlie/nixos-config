{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    # See https://dunst-project.org/documentation
    # Color theme from https://github.com/khamer/base16-dunst/blob/master/themes/base16-gruvbox-dark-hard.dunstrc
    settings = {
      global = {
        font            = "Droid Sans 10";
        frame_width     = 2;
        frame_color     = "#d5c4a1";
        separator_color = "#d5c4a1";
        transparency    = 10;
      };

      urgency_low = {
        background = "#3c3836";
        foreground = "#665c54";
      };

      urgency_normal = {
        background = "#504945";
        foreground = "#d5c4a1";
      };

      urgency_critical = {
        background = "#fb4934";
        foreground = "#ebdbb2";
      };
    };
  };
}
