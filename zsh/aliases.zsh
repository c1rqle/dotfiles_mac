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

  alias pip="pip3"
  alias python="python3"

#____________________________
  alias brewup='brew update; brew upgrade'
  alias brewss='brew search'
  alias brewS='brew install'
  alias brewi='brew info'

# ___________________________ 
# -X=sort by extension. F=classify type. t=Sort by time. r=reverse sort
  alias ls='lsd -X -tr -F'
  alias la='lsd -X -tr -A -F'
  alias l='lsd -X -ltr -F --permission octal' 
  alias ll='lsd -L -X -A -ltr -F --permission octal'
  alias lg='lsd -X -ltr --git -F' # Include git info in lists 
  alias lz='lsd -X -ltr -F --total-size --sort size --permission rwx' # Display and sort by total dir sizes
  alias tr='lsd -X -A --tree -F'
  alias tl='lsd -X -A --tree -l --git -F'
  alias tr1='lsd -X -A --tree --depth 1 -F'
  alias tr2='lsd -X -A --tree --depth 2 -F'
  alias tr3='lsd -X -A --tree --depth 3 -F'
