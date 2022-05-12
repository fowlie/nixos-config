{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xmonad.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker.enable = true;

  networking.hostName = "thinkpad-x1";  # Define your hostname.
  networking.wireless = {
    enable = true;
    networks = {

      # Use wpa_passphrase command to add to wifi entries:

      "Stollen71_5G" = {
        pskRaw = "e9b2730f7cc8cef5ed992287c58609955eb6734d341168bfebd995acf94c31d5";
      };
      "Stollen71_2.4G" = {
        pskRaw = "e9b2730f7cc8cef5ed992287c58609955eb6734d341168bfebd995acf94c31d5";
      };
    };
  };

  # Use unfree software
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Use the EURKEY layout, see https://eurkey.steffen.bruentjen.eu
  services.xserver = {
    layout = "eu";
    autoRepeatDelay = 150;
    resolutions = [
      { x = 3840; y = 2400; }
      { x = 2560; y = 1600; }
    ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Set a random wallpaper
  services.xserver.displayManager.sessionCommands = ''
    feh --bg-fill --randomize /home/mats/.config/wallpapers/*.jpg &
  '';

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  programs.fish.enable = true;

  users.users.mats = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"       # Enable ‘sudo’ for the user.
      "audio"       # Maybe not neccessary
      "networking"  # Networking
      "adbusers"    # Android development
      "docker"      # Docker
    ];
  };

  # Enable Android Debug Bridge
  programs.adb.enable = true;

  nix.allowedUsers = [ "@wheel" ]; # Allow users with sudo to contact the nix server

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable auto toggle for Thinkpad backlighting
  # services.tp-auto-kbbl.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    naturalScrolling = true;
    accelSpeed = "2.0";
  };

  # Enable brightness buttons on laptop
  services.illum.enable = true;

  environment.systemPackages = with pkgs; [
    feh   # Set background images
  ];

  system.stateVersion = "21.11";
}
