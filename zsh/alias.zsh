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
alias gs='git status'
alias gd='git diff'
alias gdw='git diff --color-words'

alias t='tig'
alias ta='tig --all'
