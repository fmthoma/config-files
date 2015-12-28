if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -lF --color=always'
alias la='ls -AlF --color=always'
alias l='ls -CF --color=always'
alias md='mkdir -p'

alias less="less -R"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias asdf='setxkbmap de neo'
alias uiae='setxkbmap de'

alias clip='xsel -op | xsel -ib'

alias r='ranger'

alias g='git'
alias gs='git s'
alias gd='git d'
alias gds='git ds'
alias gdw='git dw'
alias gdww='git dww'
alias gf='git f'
alias gr='git r'
alias gri='git ri'
alias gp='git p'
alias gst='git st'
alias gsp='git sp'

alias t='tig'
alias ta='tig --all'
alias tu='tig HEAD @{upstream}'
alias tg='tig grep'

alias zz='source ~/.zshrc'
