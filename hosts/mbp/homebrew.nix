# /Users/tb/dotfiles_mac/hosts/mbp/homebrew.nix
#
# Declarative Homebrew config via nix-darwin.
#
# NOTE: fzf, starship, zoxide, zsh-autosuggestions, zsh-syntax-highlighting
# are intentionally omitted — they're managed by Home Manager (programs.*).
#
# NOTE: cargo packages (cargo-generate, cargo-leptos, wasm-bindgen-cli,
# wasm-pack) are not supported by this module — manage via `cargo install`
# or migrate to pkgs.rustPlatform.buildRustPackage in the future.
{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false; # run `brew update` manually
      upgrade    = false; # run `brew upgrade` manually
      # "uninstall" removes formulae/casks no longer listed here.
      # Change to "zap" to also remove all dependencies.
      # Change to "none" if you want to manage removals manually.
      cleanup = "uninstall";
    };

    # ── Taps ──────────────────────────────────────────────────────────────────
    taps = [
      "felixkratz/formulae"
    ];

    # ── Formulae ──────────────────────────────────────────────────────────────
    brews = [
      # Build tools
      "clang-format"
      "cmake"
      "gcc"
      "make"
      "ninja"

      # Rust
      "rustup"

      # Ruby
      "ruby"

      # Python
      "python@3.13"
      "python@3.14"
      "pillow"

      # Perl
      "perl"

      # Lua
      "lua"
      "luarocks"

      # Node / JS
      "node"
      "pnpm"
      "yarn"

      # WebAssembly toolchain
      "wasm-component-ld"
      "wasm-micro-runtime"
      "wasm-pack"
      "wasm-tools"

      # Git
      "git"
      "git-filter-repo"

      # GitHub
      "gh"

      # Shell / terminal utilities
      "fd"
      "findutils"
      "jq"
      "ripgrep"
      "glow"          # markdown in terminal
      "lsd"           # ls replacement
      "vivid"         # LS_COLORS generator
      "translate-shell"
      "xdg-ninja"     # audits $HOME for XDG compliance

      # File management
      "nnn"

      # Media
      "ffmpeg"
      "imagemagick"
      "yt-dlp"

      # Multiplexer
      "tmux"

      # Neovim
      "neovim"

      # Kubernetes
      "click"

      # Network
      "cloudflared"
      "openssh"
      "wireshark"

      # Docker (CLI only; Docker Desktop is the cask below)
      "docker"
      "docker-compose"

      # System monitoring
      "fastfetch"
      "macmon"

      # Misc
      "man-db"
      "mas"           # Mac App Store CLI
      "stow"
      "powerline-go"

      # Services
      { name = "ollama"; restart_service = "changed"; }
      "syncthing"

      # AI dev tools
      "claude-code-templates"
      "claudekit"

      # ICU (linked so native extensions can find it)
      { name = "icu4c@77"; link = true; }

      # Tap formula
      "felixkratz/formulae/borders"
    ];

    # ── Casks ─────────────────────────────────────────────────────────────────
    casks = [
      # Fonts (used by lsd, Starship, Ghostty, etc.)
      "font-awesome-terminal-fonts"
      "font-hack-nerd-font"
      "font-ligature-symbols"
      "font-powerline-symbols"
      "font-sf-pro"
      "font-sketchybar-app-font"
      "font-symbols-only-nerd-font"

      # Terminal
      "ghostty"

      # Browsers
      "ungoogled-chromium"

      # Dev tools
      "vscodium"
      "docker-desktop"
      "android-platform-tools"
      "github"           # GitHub Desktop

      # AI tools
      "claude"
      "claude-code"
      "chatgpt"
      "auto-claude"

      # Productivity
      "raycast"
      "notion"
      "espanso"
      "hammerspoon"
      "bettertouchtool"
      "karabiner-elements"
      "ubersicht"

      # Window / desktop management
      "spaceid"
      "sf-symbols"

      # Mouse / input
      "linearmouse"
      "logi-options+"
      "logitech-g-hub"

      # Media / entertainment
      "spotify"
      "stolendata-mpv"
      "biglybt"
      "qbittorrent"

      # Utilities
      "aldente"          # battery charge limiter
      "pearcleaner"      # app uninstaller
      "syncthing-app"    # Syncthing menu bar
      "termius"          # SSH client
      "surfshark"        # VPN

      # Communication
      "discord"
      "tuta-mail"
    ];

    # ── Mac App Store ─────────────────────────────────────────────────────────
    masApps = {
      "Amphetamine"        = 937984704;
      "Bitwarden"          = 1352778147;
      "darker"             = 1637413102;
      "Dynamic Wallpaper"  = 1582358382;
      "Notion Web Clipper" = 1559269364;
      "uBlock Origin Lite" = 6745342698;
      "Vimari"             = 1480933944;
    };
  };
}
