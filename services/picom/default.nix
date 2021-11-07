{
  services.picom = {
    enable = true;
    activeOpacity = "0.9";
    inactiveOpacity = "0.9";
    opacityRule = [ "100:name *= 'rofi'" ];
    shadow = true;
  };
}
