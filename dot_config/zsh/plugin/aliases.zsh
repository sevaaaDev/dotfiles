#!/bin/sh

# ls
alias ls='lsd'
alias la='lsd -a'
alias lsa='lsd -a'
alias ll='lsd -l'
alias lla='lsd -la'
alias tree='lsd --tree'

# cd
alias bd='cd ..'

# dont fck up
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias tp='trash-put'

# better grep
alias grep='grep --color=auto'

# cls
alias cls='clear'

# nvim
alias vim='nvim'
alias nv='nvim'
alias nvconf='cd $HOME/.config/nvim/'

# chezmoi
alias dotfile='cd $HOME/.local/share/chezmoi/'

# lazygit
alias lgit='lazygit'

# cat bat
alias cat='batcat'
alias bat='batcat'
