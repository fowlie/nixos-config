# NixOS config

My current - and always evolving - NixOS configuration files, home-manager, neovim, etc.
Inspired by https://gvolpe.com/blog/xmonad-polybar-nixos


## First time setup

Install NixOS and symlink /etc/nixos/configuration.nix to ./configuration.nix.


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
