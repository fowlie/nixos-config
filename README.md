# NixOS config

My current - and always evolving - NixOS configuration files, home-manager, neovim, etc.
Inspired by https://gvolpe.com/blog/xmonad-polybar-nixos

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

- [ ] Symlink /etc/nixos/configuration.nix and put it in the repo
- [ ] Show workspaces in xmobar
- [ ] Pimp xmobar with icons
- [ ] Show focused window title in xmobar
- [ ] Add beautiful desktop backgrounds
- [ ] Migrate my neovim config
- [ ] Configure neovim-lsp for java
- [ ] Setup Rofi with pass
- [ ] Split the configuration files to match other machines
- [ ] Have Rofi show up on Super key press alone
- [ ] Add Super+Arrow keybindings to select/move windows
- [x] Add some space between the windows in XMonad
- [x] Set vim as default editor, at least for git (or via the EDITOR env variable)
