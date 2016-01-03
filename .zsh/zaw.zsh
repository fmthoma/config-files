[ -d "$(dirname $0)/zaw" ] || return 1

source "$(dirname $0)/zaw/zaw.zsh"

zstyle ':filter-select:highlight' matched fg=red,bold
zstyle ':filter-select' max-lines 32
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes

autoload -Uz narrow-to-region

function _zaw-history
{
    local state

    LB="${LBUFFER##*(\||&)}"
    LB="${LB#"${LB%%[\![:space:]]*}"}" # remove leading spaces
    LBUFFER="${LBUFFER%$LB}"

    RB="${RBUFFER%%(\||&)*}"
    RB="${RB%"${RB##*[\![:space:]]}"}" # remove trailing spaces
    RBUFFER="${RBUFFER#$RB}"

    CURSOR=${#LBUFFER}
    MARK=CURSOR

    narrow-to-region -p "$LBUFFER${BUFFER:+ }" -P "${BUFFER:+ }$RBUFFER" -S state

    BUFFER="$LB$RB"
    LBUFFER="$LB"
    RBUFFER="$RB"
    zle zaw-history

    narrow-to-region -R state
}

zle -N _zaw-history

bindkey "^R" _zaw-history
bindkey -M filterselect "^R" up-line-or-history

bindkey "^B" zaw-git-branches
