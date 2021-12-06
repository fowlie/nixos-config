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

  networking.hostName = "thinkpad-x1";  # Define your hostname.
  networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.
  networking.wireless.environmentFile = "/run/secrets/wireless.env";
  # Ref https://nixos.org/manual/nixos/stable/options.html#opt-networking.wireless.environmentFile
  networking.wireless.networks = {
    "Stollen71_5G".psk = "@PSK_STOLLEN71@";
    "ITverket".psk = "@PSK_ITVERKET@";
  };

  # Use unfree software
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  services.xserver.layout = "us,no";
  services.xserver.xkbVariant = "euro,";
  services.xserver.xkbOptions = "caps:ctrl_modifier,grp:shifts_toggle";

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
      "wheel" # Enable ‘sudo’ for the user.
      "audio"
      "networking"
      "adbusers"
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

  # Enable brightness buttons on laptop
  services.illum.enable = true;

  environment.systemPackages = with pkgs; [
    feh   # Set background images
  ];

  system.stateVersion = "21.11";
}
