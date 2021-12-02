{
  services.picom = {
    enable = true;
    activeOpacity = "1.0";
    inactiveOpacity = "0.9";
    fade = true;
    backend = "glx";
    opacityRule = [
      "100:name *= 'rofi'"
    ];
    shadow = true;
  };
}
