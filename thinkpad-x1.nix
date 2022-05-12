{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./common.nix
    ./programs/default.nix
    ./services/default.nix
  ];

  # Terminal font size is unique laptops screen
  programs.alacritty.settings.font.size = 7;

  programs.git = {
    enable = true;
    userName = "Mats Faugli";
    userEmail = "mats.faugli@gmail.com";
  };

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "mats";
    homeDirectory = "/home/mats";
    packages = with pkgs; [
      discord
      firefox
      gimp
      godot
      google-chrome
      htop
      killall
      libnotify           # Provides notify-send
      maven3
      nerdfonts
      slack
      spaceFM
      spotify
      teams
      usbutils
      xclip
      xorg.xev             # Get keyboard button names with `xev -event keyboard`

      # Android development
      android-studio
      android-tools
      flutter
    ];
    sessionVariables = {
      # Make Swing apps work in XMonad
      # Ref https://wiki.haskell.org/Xmonad/Frequently_asked_questions#Problems_with_Java_applications.2C_Applet_java_console
      _JAVA_AWT_WM_NONREPARENTING=1;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
