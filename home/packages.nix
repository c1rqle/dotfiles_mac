{ pkgs, ... }:
{
  home.packages = with pkgs; [
  # Tools
    git
    git-filter-repo
    translate-shell
    jankyborders
    imagemagick
    findutils
    fastfetch
    lscolors
    ripgrep
    ffmpeg
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
  # Applications 
    karabiner-elements
    goku
    bitwarden-desktop
    bitwarden-cli
    ghostty-bin
    qbittorrent
    notion-app
    alacritty
    spotify
    discord
    aldente
    raycast
    vncdo
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
    cloudflared
    termshark
    openssh
    rustup
    nodePackages_latest.nodejs
    python314Packages.python
    python314Packages.pillow
    luajitPackages.luarocks
    ninja_1_11
    powerline-go
    pipx
    yarn
    pnpm
    lua
    mas
    man
    macmon
    sketchybar
    sketchybar-app-font
    sbarlua
  ];
}
