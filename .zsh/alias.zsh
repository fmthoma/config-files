if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias igrep='grep -i'
alias rgrep='grep -Hrn'
alias irgrep='rgrep -i'
alias -g G=' | grep'

alias ls='ls --color=auto'
if ! (which lsd &> /dev/null); then
    alias lsd='ls --color=always'
fi
alias ll='lsd -lF'
alias la='lsd -AlF'
alias l='lsd -F'
alias md='mkdir -p'

alias less='less -RS'
alias -g L=' | less'
alias -g -- --help='--help 2>&1 | less'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias asdf='setxkbmap de neo'
alias uiae='setxkbmap de'

alias clip='xsel -op | xsel -ib'

alias r='ranger'

alias gradle='./gradlew'

alias nix-shell='nix-shell --run zsh'

alias g='git'
alias gb='git b'
alias gs='git s'
alias gd='git d'
alias gds='git ds'
alias gdw='git dw'
alias gdww='git dww'
alias gf='git f'
alias gr='git r'
alias gri='git ri'
alias gp='git p'
alias gpf='git pf'
alias gpu='git pu'
alias gst='git st'
alias gsp='git sp'

alias t='tig'
alias ta='tig --all'
alias tu='tig HEAD @{upstream}'
alias tg='tig grep'

alias zz='~/config-files/install/this; source ~/.zshrc; source ~/.profile'

if (which ncal &> /dev/null); then
    alias cal='ncal -bwy'
else
    alias cal='cal -wy'
fi
