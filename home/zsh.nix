# /Users/tb/dotfiles_mac/home/zsh.nix
{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;

    oh-my-zsh = {
      enable = true;

      # fzf, starship, zoxide removed — each has its own programs.* block below
      plugins = [ "git" "colored-man-pages" "tmux" "zsh-autopair" "zsh-syntax-highlighting" "zsh-autosuggestions" ];

      # Points to user-managed custom plugins/aliases dir
      custom = "$HOME/.config/zsh_custom";

      # Set before oh-my-zsh is sourced
      extraConfig = ''
        DISABLE_UNTRACKED_FILES_DIRTY="true"
        zstyle ':omz:update' mode auto
        zstyle ':omz:update' frequency 4
      '';
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
        export PATH="/opt/homebrew/bin:$PATH"
        export HOMEBREW_NO_AUTO_UPDATE=1
      '')

      ''
        setopt autocd extendedglob nomatch notify
        unsetopt beep
        bindkey -v

        zstyle ':completion:*' completer _oldlist _expand _complete _match _correct _approximate _prefix
        zstyle ':completion:*' max-errors 99 not-numeric
        zstyle ':completion:*' match-original both
        zstyle ':completion:*' old-menu false
        zstyle ':completion:*' completions 1
        zstyle ':completion:*' substitute 1
        zstyle ':completion:*' word true
        zstyle ':completion:*' glob 1

        if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR='vim'
        else
          export EDITOR='nvim'
        fi

        export ARCHFLAGS="-arch $(uname -m)"
        [[ -f "$HOME/.config/zsh_custom/aliases" ]] && source "$HOME/.config/zsh_custom/aliases"

        bindkey '^A' beginning-of-line
        bindkey '^E' end-of-line
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
