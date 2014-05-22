#!/bin/bash
alias la='ls -alh --color=auto'
cs() { cd $@ && la; }

alias e='vim'
alias cl='clear'

alias cdl='cd && cl'

alias open='kde-open'
alias ko='konsole -e'

alias pianobar='rm ~/.config/pianobar/out; pianobar | tee ~/.config/pianobar/out'

alias kpcli-my='kpcli --kdb=/home/andrew/Dropbox/keepass2/Database.kdbx --key=/home/andrew/Dropbox/keepass2/pwsafe.key'
