{ pkgs, ... }:
{
  home.packages = with pkgs; [
  # Tools
    #    nushell
    #    carapace
    #    gcc
    tmux
    lsd
    nnn
    gh
    #fd
    git
    git-filter-repo
    translate-shell
    jankyborders
    findutils
    termimage
    lscolors
    #ripgrep
    ffmpeg
    yt-dlp
    vivid
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
    basalt # Obsidian from the terminal
    lazyssh
    lazycli
    lazygit
    lazydocker
    lazyjournal
  # Terminal things
    docker
    docker-gc
    docker-ls
    docker-compose
    docker-color-output
  # powerline-go
    cloudflared
    termshark
    openssh
    mas
    man
    macmon
    tealdeer
    fastfetch
    rPackages.okxAPI
  ];
}
