#_________________________ 
  export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
  export PATH="/opt/homebrew/bin:$PATH >> ~/.zprofile && source ~/.zprofile"
  export ZSH="$HOME/.oh-my-zsh"
#_________________________ 
  export PATH=/opt/homebrew/opt/rustup/bin:$PATH 
#_________________________ 
  export PATH=/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  
#_________________________ 
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
#_________________________ 
  if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
  fi

#_____________________________________
# Starship is handling the shell functionality. LS_COLORS and LSD are for bonus colours :)
  export LS_COLORS="$(vivid generate tokyonight-night)"

#_____________________________________
  setopt autocd extendedglob nomatch notify
  unsetopt beep
  bindkey -v

#_____________________________________
  zstyle ':completion:*' completer _oldlist _expand _complete _match _correct _approximate _prefix
  zstyle ':completion:*' max-errors 99 not-numeric
  zstyle :compinstall filename '/Users/tb/.zshrc'
  zstyle ':completion:*' match-original both
  zstyle ':completion:*' old-menu false
  zstyle ':completion:*' completions 1
  zstyle ':completion:*' substitute 1
  zstyle ':completion:*' word true
  zstyle ':completion:*' glob 1
  autoload -Uz compinit
  compinit

#_____________________________________
# Disable auto updates from brew 
  export HOMEBREW_NO_AUTO_UPDATE=1

#_____________________________________
# oh-my-zsh update behaviour
  zstyle ':omz:update' mode reminder
  zstyle ':omz:update' frequency 13


  bindkey '^[[1;9C' forward-word
  bindkey '^[[1;9D' backward-word

#_____________________________________
# Disable autocorrect. I find it incredibly annoying.
  ENABLE_CORRECTION="false"

#_____________________________________
# This makes repository status check much faster.
  DISABLE_UNTRACKED_FILES_DIRTY="true"

#_____________________________________
# ZSH plugins
 ZSH_CUSTOM=~/.config/zsh_custom
 plugins=(git fzf starship colored-man-pages tmux zoxide)

#_____________________________________
# Loading my aliases
  [ -f ~/.config/zsh_custom/aliases.zsh ] && source ~/.config/zsh_custom/aliases.zsh

#_____________________________________
# fzf
#	export FZF_BASE=/run/current-system/sw/bin/fzf
  set rtp+=/opt/homebrew/opt/fzf
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
  source <(fzf --zsh)
  
#_____________________________________
# Activating zoxide
  eval "$(zoxide init --cmd c zsh)"
  eval "$(starship init zsh)"
