# NixOS config

My current - and always evolving - NixOS configuration files, home-manager, neovim, etc.
Inspired by https://gvolpe.com/blog/xmonad-polybar-nixos


## First time setup

Install NixOS and symlink /etc/nixos/configuration.nix to ./configuration.nix.
  - `sudo ln --force -s ~/.config/nixpkgs/configuration.nix /etc/nixos/configuration.nix`

### Install homemanager
Set up the home manager channel.
```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
nix-channel --update
```
Log out and log back in.

Run the install command
`nix-shell '<home-manager>' -A install`


## Programs

| Type           | Program      |
| :------------- | :----------: |
| Editor         | [NeoVim](https://neovim.io/) |
| File Manager   | [Ranger](https://ranger.github.io/) |
| Launcher       | [Rofi](https://github.com/davatorium/rofi) |
| Shell          | [Fish](https://fishshell.com/) |
| Status Bar     | [Xmobar](https://github.com/jaor/xmobar) |
| Terminal       | [Alacritty](https://github.com/alacritty/alacritty) |
| Window Manager | [XMonad](https://xmonad.org/) |


## Keybindings

In addition to XMonad's [default keybindings](https://xmonad.org/images/cheat/xmbindings.png),
there's also:

* `Mod+p` for Rofi
* `Mod+[` for Firefox
* `Mod+]` for Ranger


## Todo

- [ ] Pimp xmobar with icons
- [ ] Migrate my neovim config
- [ ] Configure neovim-lsp for java
- [ ] Setup Rofi with pass
- [ ] Split the configuration files to match other machines
- [ ] Have Rofi show up on Super key press alone
- [ ] Replace Rofi with dmenu...?
- [ ] Add Super+Arrow keybindings to select/move windows
- [ ] Consider migrating to flake
- [ ] Migrate ideavimrc
- [x] Add a nerdfont to alacritty
