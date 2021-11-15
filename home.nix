{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/default.nix
    ./services/default.nix
  ];

  programs.git = {
    enable = true;
    userName = "Mats Faugli";
    userEmail = "mats.faugli@gmail.com";
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "mats";
    homeDirectory = "/home/mats";
    packages = [
      pkgs.alacritty
      pkgs.firefox
      pkgs.gimp
      pkgs.killall
      pkgs.neofetch
      pkgs.qutebrowser
      pkgs.xclip
    ];
    sessionVariables = {
      EDITOR = "nvim";
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
