# /Users/tb/dotfiles_mac/hosts/mbp/homebrew.nix
#     Declarative Homebrew config via nix-darwin.
# //
# NOTE: Apps and utilities that isn't available in Nix for Mac yet. Or for some other reason needs brew.

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
      "gcc" # GNU compiler collection
      "glow" # Markdown in terminal
      "ta-lib" # crypto related
      "scrcpy" # Android screen sharing
      "carapace" # Multi-shell multi-command argument completer
      "adb-enhanced" # Android tools
      "tree-sitter"
      "tree-sitter-cli"
      "haskell-language-server"
      ## Py
      "python@3.14"
      "pyp"
      "pipx"
      "pip-tools"
      "virtualenv"
      #"python-lsp-server"
      "python-markdown"
      ## ruby
      "ruby"
      "ruby-lsp"
      "rustup"
      "rust-analyzer"
      ##
      "go"
      "golangci-lint-langserver"
      ##
      "lua@5.4" # To satisfy Neovim
      "luarocks"
      ## The makers and the builders
      "multimarkdown"
      "neocmakelsp"
      "typos-lsp"
      "dotnet"
      "cmake"
      "ninja"
    ## Linting
      "markdownlint-cli"
      "golangci-lint"
      "cmake-lint"
      "pylint"
    ## Docker
      "colima"
      "docker"
      "docker-compose"
      "docker-completion"
      "lazydocker"
    ## Services
      #{ name = "ollama"; restart_service = "changed"; }
      # ICU (linked so native extensions can find it)
      { name = "icu4c@77"; link = true; }

    ];

    # ── Casks ─────────────────────────────────────────────────────────────────
    casks = [
      "font-awesome-terminal-fonts"
      "font-symbols-only-nerd-font"
      "font-powerline-symbols"
      "font-ligature-symbols"
      "font-hack-nerd-font"
      "font-sf-pro"
      "sf-symbols"

      # Input
      "karabiner-elements"      # Keyboard customiser
      "logitech-g-hub"          # Gaming things
      "logi-options+"           # Also gaming things
      "linearmouse"             # Mouse customiser

      # Utilities
      "android-platform-tools"  # adb thingy - needed for scrcpy
      "wireshark-chmodbpf"
      "google-drive"
      "pearcleaner"             # app uninstaller
      "surfshark"               # VPN
      "raycast"                 # App starter etc

      # Productivity
      "espanso"
      "tuta-mail"
      "ubersicht"
      "hammerspoon"
      "dotnet-runtime"
      "bettertouchtool"
      "markdown-service-tools"
      "ia-markdown-dictionary"
    ];

    # ── Mac App Store ─────────────────────────────────────────────────────────
    masApps = {
      "Dynamic Wallpaper"           = 1582358382; # Enables animated wallpaper 
      "Amphetamine"                 = 937984704;  # Keep awake

      # Safari extensions ↓
      "Nightshift Dark Mode"        = 1561604170;
      "uBlock Origin Lite"          = 6745342698;
      "Notion Web Clipper"          = 1559269364;
      #"OKX Wallet"                  = 6463797825;
      "Bitwarden"                   = 1352778147;
      "Vimari"                      = 1480933944;
    };
  };
}
