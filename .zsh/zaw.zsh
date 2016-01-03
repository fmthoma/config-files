[ -d "$(dirname $0)/zaw" ] || return 1

source "$(dirname $0)/zaw/zaw.zsh"

zstyle ':filter-select:highlight' matched fg=red,bold
zstyle ':filter-select' max-lines 32
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes



################################################################################
# History                                                                      #
################################################################################
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



################################################################################
# Git branches                                                                 #
################################################################################
bindkey "^B" zaw-git-branches



################################################################################
# Autocompletion (fasd, git)                                                   #
################################################################################
function zaw-src-autocompletion () {
    local lb rb buffer cmdln cmd args

    actions=("zaw-callback-append-and-execute" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "append to edit buffer")

    lb="${LBUFFER##*(\||&)}"
    lb="${lb#"${lb%%[\![:space:]]*}"}" # remove leading spaces
    rb="${RBUFFER%%(\||&)*}"
    rb="${rb%"${rb##*[\![:space:]]}"}" # remove trailing spaces
    buffer="$lb$rb"
    cmdln=( "${=buffer}" )

    cmd="${cmdln[1]}"
    args=( "${cmdln[2,-1]}" )

    case "$cmd" in
      "cd"|"j")
        candidates=( $( fasd -dl ) )
        ;;
      "vi"|"less")
        candidates=( $( fasd -fl ) )
        ;;
      *)
        candidates=( $( fasd -al ) )
    esac

    BUFFER="$cmd"
    options=( "-r" "-n" "-m" "-s" "$args" )
}

function zaw-callback-append-and-execute () {
    BUFFER="$BUFFER ${(j:; :)@}"
    zle accept-line
}

zaw-register-src -n autocompletion zaw-src-autocompletion

bindkey "^@" zaw-autocompletion
