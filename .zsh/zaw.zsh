[ -d "$(dirname $0)/zaw" ] || return 1

source "$(dirname $0)/zaw/zaw.zsh"

zstyle ':filter-select:highlight' matched fg=red,bold
zstyle ':filter-select' max-lines 32
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes



################################################################################
# Common utilities
################################################################################
autoload -Uz narrow-to-region

function narrow-to-current-command() {
    LB="${LBUFFER##*(\||&)}"
    LB="${LB#"${LB%%[\![:space:]]*}"}" # remove leading spaces
    LBUFFER="${LBUFFER%$LB}"

    RB="${RBUFFER%%(\||&)*}"
    RB="${RB%"${RB##*[\![:space:]]}"}" # remove trailing spaces
    RBUFFER="${RBUFFER#$RB}"

    CURSOR=${#LBUFFER}
    MARK=CURSOR

    narrow-to-region -p "$LBUFFER${BUFFER:+ }" -P "${BUFFER:+ }$RBUFFER" $@

    BUFFER="$LB$RB"
    LBUFFER="$LB"
    RBUFFER="$RB"
}



################################################################################
# History                                                                      #
################################################################################
function _zaw-history
{
    local state

    narrow-to-current-command -S state
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
    args=( "${=cmdln[2,-1]}" )

    case "$cmd" in
      "cd"|"j")
        candidates=( $( fasd -dlR ) )
        ;;
      "vi"|"less")
        candidates=( $( fasd -flR ) )
        ;;
      "git"|"g"|"tig"|"t")
        cmd="$cmd ${args[1,-2]}"
        args=( "${args[-1]}" )
        if ( git status > /dev/null 2>&1 ); then
            branches=( $( git show-ref | awk '$2 != "refs/stash" { print $2 }' ) )
            candidates=( "${branches[@]#refs/(heads|remotes)/}" )
        fi
        ;;
      *)
        candidates=( $( fasd -alR ) )
    esac

    BUFFER="$cmd "
    options=( "-m" "-s" "$args" )
}

function zaw-callback-append-and-execute () {
    BUFFER="$BUFFER${(j:; :)@}"
    zle accept-line
}

zaw-register-src -n autocompletion zaw-src-autocompletion

bindkey "^@" zaw-autocompletion
