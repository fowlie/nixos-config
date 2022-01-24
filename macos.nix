{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mats";
  home.homeDirectory = "/Users/mats";

  imports = [
    ./programs/alacritty
    ./programs/bat
    ./programs/exa
    ./programs/fish
    ./programs/fzf
    ./programs/git
    ./programs/neovim
    ./programs/ranger
  ];

  programs.fish.shellInit =
  ''
    # nix
    if test -e /nix/var/nix/profiles/default/etc/profile/d/nix-daemon.sh
      fenv source /nix/var/nix/profiles/default/etc/profile/d/nix-daemon.sh
    end

    # add nix and home-manager binaries
    set -x PATH $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin $PATH

    # configure golang
    set -x GOPRIVATE "bitbucket.tech.dnb.no/*"
    set -x PATH $HOME/go/bin $PATH
  '';

  # Customers GitProxy
  programs.fish.shellAliases = {
    gproxy        = "sudo ssh -f -nNT gitproxy";
    gproxy-status = "sudo ssh -O check gitproxy";
    gproxy-off    = "sudo ssh -O exit gitproxy";
  };

  programs.git.userName = "Mats Faugli";
  programs.git.userEmail = "mats.faugli@dnb.no";
  programs.git.extraConfig = {
    url."ssh://git@git.tech-01.net/".insteadOf = "https://bitbucket.tech.dnb.no/scm/";
  };

  home.packages = with pkgs; [
    awscli2
    bottom
    go
    gopls
    go-mockery
    jq
    neofetch
    nerdfonts
    nodejs
    ripgrep
    tldr
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
