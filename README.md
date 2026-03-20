# My Mac dotfiles

---

This is my recipe for adopting the look, feel and functionality of
Linux's Hyprland to mac 🫠

Yabai + Hammerspoon + JankyBorders for the Hyprland feel. Add Übersicht
and simple-bar for the added Waybar feel

- [Yabai](https://github.com/asmvik/yabai)
- [Hammerspoon](https://github.com/Hammerspoon/hammerspoon)
- [Jankyborders](https://github.com/FelixKratz/JankyBorders)
- [Übersicht](https://github.com/felixhageloh/uebersicht)
  - [Simple-bar addon](https://github.com/Jean-Tinland/simple-bar)

---

All the other dotfiles is for making my terminal pretty.

## Nix

The repo flake is the canonical source of truth now.

- Main config: [`/Users/tb/dotfiles_mac/flake.nix`](/Users/tb/dotfiles_mac/flake.nix)
- Host module: [`/Users/tb/dotfiles_mac/hosts/mbp/default.nix`](/Users/tb/dotfiles_mac/hosts/mbp/default.nix)
- Home Manager entry: [`/Users/tb/dotfiles_mac/home/default.nix`](/Users/tb/dotfiles_mac/home/default.nix)

Typical rebuild:

```bash
darwin-rebuild switch --flake ~/dotfiles_mac#mbp
```

`/etc/nix-darwin/flake.nix` should only be a tiny bootstrap shim that forwards to this repo, not a second real config. Two competing flakes is how chaos gets tenure.
