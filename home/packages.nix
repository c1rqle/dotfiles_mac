{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    bitwarden-desktop
    chatgpt
    claude-code
    claude-monitor
    discord
    ghostty-bin
    jankyborders
    lsd
    neovim
    nnn
    notion-app
    qbittorrent
    spotify
    tmux
    vscodium
  ];
}
