{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./kerberos.nix
      ./xmonad.nix
    ];

  # VMWare
  virtualisation.vmware.guest.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use unfree software
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Set a random wallpaper
  services.xserver.displayManager.sessionCommands = ''
    feh --bg-fill --randomize /home/mats/.config/wallpapers/*.jpg &
  '';

  networking.useDHCP = false;
  networking.interfaces.ens33.useDHCP = true;

  programs.fish.enable = true;

  users.users.mats = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ]; # Enable ‘sudo’ for the user.
  };

  # flakes
#  nix = {
#    package = pkgs.nixFlakes;
#    extraOptions = ''
#      experimental-features = nix-command flakes
#    '';
#  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    qutebrowser

    # flakes as an extra command
    # (pkgs.writeShellScriptBin "nixFlakes" ''
    #   exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    # '')
  ];

  system.stateVersion = "21.05"; # Did you read the comment?
}
