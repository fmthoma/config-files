source "$(dirname $0)/zaw/zaw.zsh"

zstyle ':filter-select:highlight' matched fg=red,bold
zstyle ':filter-select' max-lines 32
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes

bindkey "^R" zaw-history
bindkey -M filterselect "^R" up-line-or-history
bindkey -M filterselect "^M" accept-search
