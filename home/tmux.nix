# /Users/tb/dotfiles_mac/home/tmux.nix
{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

    terminal = "tmux-256color";
    historyLimit = 50000;
    mouse = true;
    keyMode = "vi";
    prefix = "C-s";
  };

  xdg.configFile = {
    "tmux/tmux.conf".source          = ../tmux/tmux.conf;
    "tmux/keybindings.conf".source   = ../tmux/keybindings.conf;
    "tmux/appearance.conf".source    = ../tmux/appearance.conf;
    "tmux/plugins.conf".source       = ../tmux/plugins.conf;

    "tmux/plugins".source            = ../tmux/plugins;
    "tmux/plugins".recursive         = true;
  };
}
