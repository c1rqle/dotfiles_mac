# /Users/tb/dotfiles_mac/home/zsh.nix
{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;

      # fzf, starship, zoxide removed — each has its own programs.* block below
      plugins = [ "git" "colored-man-pages" "tmux" ];

      # Points to user-managed custom plugins/aliases dir
      custom = "$HOME/.config/zsh_custom";

      # Set before oh-my-zsh is sourced
      extraConfig = ''
        DISABLE_UNTRACKED_FILES_DIRTY="true"
        zstyle ':omz:update' mode auto
        zstyle ':omz:update' frequency 4
      '';
    };

    # External plugins sourced from nixpkgs (replaces Homebrew-installed versions)
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        # Verified path in nix store
        file = "share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];

    initContent = lib.mkMerge [
      # Runs at the very top of .zshrc — before oh-my-zsh and compinit
      (lib.mkBefore ''
        # PATH
        export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
        # Ruby gems — path is version-dependent; only add if dir exists
        for _ruby_gems_dir in /opt/homebrew/lib/ruby/gems/*/bin; do
          [[ -d "$_ruby_gems_dir" ]] && export PATH="$_ruby_gems_dir:$PATH"
        done
        unset _ruby_gems_dir

        # Homebrew
        export HOMEBREW_NO_AUTO_UPDATE=1

        # LS_COLORS (requires vivid in PATH, installed via Homebrew)
        export LS_COLORS="$(vivid generate tokyonight-night)"

        # Ghostty terminal integration
        if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
          source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
        fi
      '')

      # Runs after oh-my-zsh and plugin sourcing
      ''
        # Shell options
        setopt autocd extendedglob nomatch notify
        unsetopt beep
        bindkey -v

        # Completion tuning (oh-my-zsh handles compinit — do NOT call it again here)
        zstyle ':completion:*' completer _oldlist _expand _complete _match _correct _approximate _prefix
        zstyle ':completion:*' max-errors 99 not-numeric
        zstyle ':completion:*' match-original both
        zstyle ':completion:*' old-menu false
        zstyle ':completion:*' completions 1
        zstyle ':completion:*' substitute 1
        zstyle ':completion:*' word true
        zstyle ':completion:*' glob 1

        # Editor
        if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR='vim'
        else
          export EDITOR='nvim'
        fi

        # Compilation flags (for Ruby and other native extensions)
        export ARCHFLAGS="-arch $(uname -m)"
        export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
        export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"

        # Starship config location
        export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

        # Perl local::lib
        eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

        # Aliases (user-managed, not migrated to Nix yet)
        [[ -f "$HOME/.config/zsh_custom/aliases.zsh" ]] && source "$HOME/.config/zsh_custom/aliases.zsh"
      ''
    ];
  };

  # fzf — handles its own zsh integration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # starship — handles its own zsh integration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # zoxide — --cmd c preserves the 'c' jump command from the original setup
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "c" ];
  };
}
