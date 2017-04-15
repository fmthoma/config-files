[ -f "$(dirname $0)/zaw/zaw.zsh" ] || return 1

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
    LB="${LB##[[:space:]]#}" # remove leading spaces
    LBUFFER="${LBUFFER%$LB}"

    RB="${RBUFFER%%(\||&)*}"
    RB="${RB%%[[:space:]]#}" # remove trailing spaces
    RBUFFER="${RBUFFER#$RB}"

    CURSOR=${#LBUFFER}
    MARK=CURSOR

    narrow-to-region -p "$LBUFFER${BUFFER:+}" -P "${BUFFER:+}$RBUFFER" $@

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
function _zaw-autocompletion() {
    local state
    narrow-to-current-command -S state

    cmdln=( "${=BUFFER}" )
    cmd="${cmdln[1]}"
    args=( "${=cmdln[2,-1]}" )
    BUFFER="$cmd "

    case "$cmd" in
      "cd"|"j")
        zle zaw zaw-src-autocompletion-fasd-d "$args"
        ;;
      "vi"|"less")
        zle zaw zaw-src-autocompletion-fasd-f "$args"
        ;;
      "git"|"g"|"tig"|"t")
        LBUFFER="$cmd ${args[1,-2]} "
        RBUFFER=""
        args=( "${=args[-1]}" )
        zle zaw zaw-src-autocompletion-git-branch "${args/\// / }"
        ;;
      *)
        zle zaw zaw-src-autocompletion-fasd-a "$args"
    esac

    narrow-to-region -R state
}

function zaw-src-autocompletion-fasd-f () {
    candidates=( $( fasd -flR ) )
    actions=("zaw-callback-append-and-execute" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "append to edit buffer")
    options=( "-m" "-s" "$1" )
}

function zaw-src-autocompletion-fasd-a () {
    candidates=( $( fasd -alR ) )
    actions=("zaw-callback-append-and-execute" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "append to edit buffer")
    options=( "-m" "-s" "$1" )
}

function zaw-src-autocompletion-fasd-d () {
    candidates=( $( fasd -dlR ) )
    actions=("zaw-callback-append-and-execute" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "append to edit buffer")
    options=( "-m" "-s" "$1" )
}

function zaw-src-autocompletion-git-branch () {
    local branches
    if ( git status > /dev/null 2>&1 ); then
        branches=( $( git show-ref | awk '$2 != "refs/stash" { print $2 }' ) )
        candidates=( "${branches[@]#refs/(heads|remotes)/}" )
    fi
    actions=("zaw-callback-append-and-execute" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "append to edit buffer")
    options=( "-m" "-s" "$1" )
}



function zaw-callback-append-and-execute () {
    BUFFER="$BUFFER${(j:; :)@}"
    zle accept-line
}

zaw-register-src -n autocompletion-fasd-f zaw-src-autocompletion-fasd-f
zaw-register-src -n autocompletion-fasd-a zaw-src-autocompletion-fasd-a
zaw-register-src -n autocompletion-fasd-d zaw-src-autocompletion-fasd-d
zaw-register-src -n autocompletion-git-branch zaw-src-autocompletion-git-branch

zle -N _zaw-autocompletion

bindkey "^@" _zaw-autocompletion
