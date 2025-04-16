# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
  export PATH="/opt/homebrew/bin:$PATH >> ~/.zprofile && source ~/.zprofile"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
  export ZSH="$HOME/.oh-my-zsh"
  export LS_COLORS="$(vivid generate snazzy)"
  
  ZSH_THEME="candy-kingdom"
  
  bindkey '^[[1;9C' forward-word
  bindkey '^[[1;9D' backward-word

  zstyle ':omz:update' mode auto      # update automatically without asking

# Plugins
  plugins=(z git fzf starship themes)

# fzf
	export FZF_BASE=/run/current-system/sw/bin/fzf
  source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
  fi

# Compilation flags

  export ARCHFLAGS="-arch $(uname -m)"
  source <(fzf --zsh)
  
  alias zz='cd ..'
  alias c='z'

  alias icat='kitty +kitten icat'

  alias vim='nvim'
  alias brew-s='brew search'
  alias bss='brew search'
  alias binf='brew info'

  
  alias tr='lsd -A -F -X --tree'
  alias tri='lsd -A -F -X --tree -I .git'
  alias lst='lsd -A -F -X --tree'
  alias l='lsd -ltr -F -X' 
  alias ll='lsd -ltr -F -A -X'
  alias ls='lsd -F -tr -X'
  alias la='lsd -F -tr -A -X'
  alias lstree='lsd -A -F --tree'
  alias lsx="lsd -X -R -A -F"
  
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
