{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
    lsd
    nnn
    gh
    git
    git-filter-repo
    translate-shell 
    jankyborders
    findutils
    termimage
    lscolors
    ffmpeg
    yt-dlp
    vivid
    syncthing-macos
    youtube-tui
  # Applications 
    bitwarden-desktop
    bitwarden-cli
    ghostty-bin
    qbittorrent
    notion-app
    alacritty
    obsidian
    spotify
    discord
    aldente
    vncdo
    goku
    mpv
  # Lazyness
    lazyssh
    lazycli
    lazygit
    lazyjournal
  # Terminal things
    rPackages.okxAPI
    speedtest-cli
    cloudflared
    termshark
    fastfetch
    tealdeer
    libsixel
    openssh
    macmon
    mas
    man
  ];
}
