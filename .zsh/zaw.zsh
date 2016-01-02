source "$(dirname $0)/zaw/zaw.zsh"

zstyle ':filter-select:highlight' matched fg=red,bold
zstyle ':filter-select' max-lines 32
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes

function _zaw-history
{
    local state
    MARK=CURSOR  # magick, else multiple ^R don't work

    LB=$LBUFFER
    LB=${LB##*&}
    LB=${LB##*|}
    LB=${LB##* }
    LBUFFER=${LBUFFER%$LB}

    RB=$RBUFFER
    RB=${RB%%&*}
    RB=${RB%%|*}
    RB=${RB%% *}
    RBUFFER=${RBUFFER#$RB}

    PREFIX="$LBUFFER${BUFFER:+ }"
    POSTFIX="${BUFFER:+ }$RBUFFER"

    RBUFFER=" $RBUFFER"
    #        ^ Add a space here (the first char is wrongly deleted in `narrow-to-region -R`)

    narrow-to-region -p "$PREFIX" -P "$POSTFIX" -S state

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
