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
      upgrade    = false; # run `brew upgrade` manuallyQ
      # "uninstall" removes formulae/casks no longer listed here.
      # Change to "zap" to also remove all dependencies.
      # Change to "none" if you want to manage removals manually.
      cleanup = "uninstall";
    };

    # ── Taps ──────────────────────────────────────────────────────────────────
    taps = [
      "felixkratz/formulae"
    ];

    # ── Formulae ──────────────────────────────────────────────────────────────/sketch
    brews = [
      ## Tools
      "glow" # Markdown in terminal
      "ta-lib" # Trading related
      "scrcpy" # Android screen sharing
      "imagemagick" # dependency for ↓
      "terminalimageviewer" # 
      "felixkratz/formulae/svim"
      ## Py
      "python@3.14"
      "pyp"
      "pipx"
      "pip-tools"
      "virtualenv"
      "python-lsp-server"
      "python-markdown"
      "tree-sitter-python"
      ## ruby
      "ruby"
      "ruby-lsp"
      "tree-sitter-ruby"
      ## rust 
      "rustup"
      "rust-analyzer"
      "languagetool-rust"
      "haskell-language-server"
      ##
      "go"
      "golangci-lint-langserver"
      ##
      "lua@5.4" # To satify Neovim
      "luarocks"
      "lua-language-server"
      ## The makers and the builders
      "multimarkdown"
      "neocmakelsp"
      "typos-lsp"
      "dotnet"
      "cmake"
      "ninja"
    ## Linting
      "markdownlint-cli"
      "markdownlint-cli2"
      "golangci-lint"
      "cmake-lint"
      "pylint"

      # Docker (CLI only; Docker Desktop is the cask below)
      "docker"
      "docker-compose"
      "lazydocker"

      # Services
      { name = "ollama"; restart_service = "changed"; }
      "syncthing"
      "adb-enhanced"
      # ICU (linked so native extensions can find it)
      { name = "icu4c@77"; link = true; }

    ];

    # ── Casks ─────────────────────────────────────────────────────────────────
    casks = [
      # Fonts (used by lsd, Starship, Ghostty, etc.)
      "font-awesome-terminal-fonts"
      "font-symbols-only-nerd-font"
      "font-powerline-symbols"
      "font-ligature-symbols"
      "font-hack-nerd-font"
      "font-sf-pro"
      "sf-symbols"

      # AI tools
      "claude"        # app
      "claude-code"   # claude for terminal
      "auto-claude"
      "chatgpt"
      "codex-app"     # codex app
      "codexbar"      # usage monitor for chatgpt and claude
      "codex"         # codex for terminal

      # Productivity
      "espanso"
      "tuta-mail"
      "ubersicht"
      "hammerspoon"
      "dotnet-runtime"
      "bettertouchtool"
      "markdown-service-tools"
      "ia-markdown-dictionary"

      # Mouse / input
      "linearmouse"
      "logi-options+"
      "logitech-g-hub"

      # Utilities
      "raycast"
      "pearcleaner"             # app uninstaller
      "syncthing-app"           # Syncthing menu bar
      "surfshark"               # VPN
      "android-platform-tools"  # adb 
    ];

    # ── Mac App Store ─────────────────────────────────────────────────────────
    masApps = {
      #"Dynamic Wallpaper"     = 1582358382;
      "Amphetamine"                 = 937984704;

      # Safari extensions ↓
      "snap-screenshot-snip-paste"  = 1525349531;
      "Nightshift Dark Mode"        = 1561604170;
      "uBlock Origin Lite"          = 6745342698;
      "Notion Web Clipper"          = 1559269364;
      "OKX Wallet"                  = 6463797825;
      "Bitwarden"                   = 1352778147;
      "darker"                      = 1637413102;
      "Vimari"                      = 1480933944;
    };
  };
}
