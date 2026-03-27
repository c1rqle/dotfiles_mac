#_________________________ 
  export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
  export PATH="/opt/homebrew/bin:$PATH >> ~/.zprofile && source ~/.zprofile"
  export ZSH="$HOME/.oh-my-zsh"
  export alacritty=xterm

#_____________________________________
# Starship is handling the shell functionality. LS_COLORS and LSD are for bonus colours :)
  export LS_COLORS="$(vivid generate ayu)"

#_____________________________________
# Ghostty shell integration
  if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
      source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/
  fi
#_____________________________________
  setopt autocd extendedglob nomatch notify
  unsetopt beep
  bindkey -v

#_____________________________________
  zstyle ':completion:*' completer _oldlist _expand _complete _match _correct _approximate _prefix
  zstyle ':completion:*' max-errors 99 not-numeric
  zstyle ':completion:*' match-original both
  zstyle ':completion:*' old-menu false
  zstyle ':completion:*' completions 1
  zstyle ':completion:*' substitute 1
  zstyle ':completion:*' word true
  zstyle ':completion:*' glob 1
  zstyle :compinstall filename '/Users/tb/.zshrc'
  autoload -Uz compinit
  compinit

#_____________________________________
# Disable auto updates from brew 
  export HOMEBREW_NO_AUTO_UPDATE=1

#_____________________________________
# oh-my-zsh update behaviour
  zstyle ':omz:update' mode auto
  zstyle ':omz:update' frequency 4

#_____________________________________
# This makes repository status check much faster.
  DISABLE_UNTRACKED_FILES_DIRTY="true"

#_____________________________________
# ZSH plugins and aliases
  ZSH_CUSTOM=~/.config/zsh_custom
  plugins=(git fzf starship colored-man-pages tmux zoxide zsh-autosuggestions zsh-syntax-highlighting)
#______ 
  [ -f ~/.config/zsh_custom/aliases.zsh ] && source ~/.config/zsh_custom/aliases.zsh

#_____________________________________
# fzf
  set rtp+=/opt/homebrew/opt/fzf
  source <(fzf --zsh)
  source $ZSH/oh-my-zsh.sh

#_____________________________________
# Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
  fi

#_____________________________________
# Compilation flags
  export ARCHFLAGS="-arch $(uname -m)"

#_____________________________________
# Activating Zoxide and Starship
  eval "$(zoxide init --cmd c zsh)"
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=~/.config/starship/starship.toml
