#____________________________
  alias reboot='sudo reboot'
  alias poweroff='sudo poweroff'

#____________________________
  alias ..='cd ..'
  alias .2='...'
  alias .3='....'

#____________________________
  alias mkdir='mkdir -p'
  alias vim='nvim'

#____________________________
  alias brew-up='brew update; brew upgrade'
  alias brew-Ss='brew search'
  alias brew-S='brew install'
  alias brew-i='brew info'

# ___________________________ 
# -X=sort by extension. F=classify type. t=Sort by time. r=reverse sort
  alias ls='lsd -X -tr -F'
  alias la='lsd -X -tr -A -F'
  alias l='lsd -X -ltr -F' 
  alias ll='lsd -X -A -ltr -F'
# ~/.config/lsd/config.yaml
  alias lg='lsd -X -ltr --git -F' 
  alias tr='lsd -X -A --tree -F'
  alias tr1='lsd -X -A --tree --depth 1 -F'
  alias tr2='lsd -X -A --tree --depth 2 -F'
