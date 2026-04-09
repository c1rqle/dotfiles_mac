{ pkgs, ... }:
{
  home.packages = with pkgs; [
  # Tools
    git
    git-filter-repo
    translate-shell
    jankyborders
    findutils
    fastfetch
    lscolors
    ripgrep
    ffmpeg
    neovim
    yt-dlp
    vivid
    tmux
    gcc
    lsd
    nnn
    gh
    fd
  # Applications 
    goku
    karabiner-elements
    bitwarden-desktop
    bitwarden-cli
    ghostty-bin
    qbittorrent
    notion-app
    alacritty
    spotify
    discord
    aldente
    vncdo
    mpv
  # Lazyness
    lazyssh
    lazycli
    lazygit
    lazyjournal
  # Terminal things
    cloudflared
    termshark
    openssh
    #python314Packages.python
    #python314Packages.pillow
  #  luajitPackages.luarocks
  # ninja_1_11
    powerline-go
    mas
    man
    macmon
    tealdeer
  ];
}
