# /Users/tb/dotfiles_mac/hosts/mbp/homebrew.nix
#
# Declarative Homebrew config via nix-darwin.
#
# NOTE: Apps and utilities that isn't available in Nix for Mac yet. Or for some other reason needs brew.
#
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
      "make"
      "ninja"

      # Python
      "python@3.13"
      "python@3.14"
      "pillow"

      # Lua
      "lua"
      "luarocks"

      # Media
      "ffmpeg"

      # Network
      "cloudflared"
      "openssh"
      "wireshark"

      # Docker (CLI only; Docker Desktop is the cask below)
      "docker"
      "docker-compose"

      # System monitoring
      "macmon"

      # Misc
      "man-db"
      "mas"           # Mac App Store CLI
      "powerline-go"

      # Services
      { name = "ollama"; restart_service = "changed"; }
      "syncthing"

      # ICU (linked so native extensions can find it)
      { name = "icu4c@77"; link = true; }

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

      # Browsers
      #"ungoogled-chromium"

      # AI tools
      "claude"
      "auto-claude"

      # Productivity
      #"raycast"
      "espanso"
      "hammerspoon"
      "bettertouchtool"
      "karabiner-elements"
      "ubersicht"

      # Window / desktop management
      "sf-symbols"

      # Mouse / input
      "linearmouse"
      "logi-options+"
      "logitech-g-hub"

      # Utilities
      "pearcleaner"      # app uninstaller
      "syncthing-app"    # Syncthing menu bar
      "surfshark"        # VPN
      "ungoogled-chromium"

      # Communication
      "tuta-mail"
    ];

    # ── Mac App Store ─────────────────────────────────────────────────────────
    masApps = {
      #"Dynamic Wallpaper"     = 1582358382;
      "Amphetamine"           = 937984704;

      # Safari extensions ↓
      "Nightshift Dark Mode"  = 1561604170;
      "uBlock Origin Lite"    = 6745342698;
      "Notion Web Clipper"    = 1559269364;
      "OKX Wallet"            = 6463797825;
      "Bitwarden"             = 1352778147;
      "darker"                = 1637413102;
      "Vimari"                = 1480933944;
    };
  };
}
