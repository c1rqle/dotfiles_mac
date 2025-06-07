# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to Oh My Zsh instalsdtion.
  export PATH="/opt/homebrew/bin:$PATH >> ~/.zprofile && source ~/.zprofile"
  #export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
  export ZSH="$HOME/.oh-my-zsh"
  export LS_COLORS="$(vivid generate dracula)"
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  
  if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

  ZSH_THEME="af-magic"
#_____________________________________
# Disable auto updates from brew 
  export HOMEBREW_NO_AUTO_UPDATE=1

  bindkey '^[[1;9C' forward-word
  bindkey '^[[1;9D' backward-word

# update zsh automatically without asking
  zstyle ':omz:update' mode auto      

# Plugins
  plugins=( fzf themes git starship )

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
  
#_____________________________________
# Loading my aliases
  [ -f ~/.config/zsh_custom/aliases.zsh ] && source ~/.config/zsh_custom/aliases.zsh

#_____________________________________
# Activating zoxide
  eval "$(zoxide init --cmd c zsh)"
