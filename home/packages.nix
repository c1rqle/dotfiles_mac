{ pkgs, ... }:
{
  home.packages = with pkgs; [
  # Tools
    git
    git-filter-repo
    docker
    docker-compose
  # Applications 
    ghostty-bin
    alacritty
    bitwarden-desktop
    qbittorrent
    notion-app
    spotify
    discord
    aldente
    raycast
    mpv
  # Ai tools
    chatgpt
    claude-code
    claude-monitor
  # Lazyness
    lazyssh
    lazynpm
    lazycli
    lazygit
    lazydocker
    lazyjournal
  # Terminal things
    translate-shell
    jankyborders
    imagemagick
    findutils
    fastfetch
    lscolors
    ripgrep
    neovim
    yt-dlp
    vivid
    tmux
    glow
    gcc
    lsd
    nnn
    gh
    fd
    jq
  # Fonts (will finish install later)
    #    #nerd-fonts-symbols-only
    #    nerd-fonts-caskaydia-cove
    #    texlivePackages-addliga
    #    font-awesome
  ];
}
