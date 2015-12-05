# see http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html

zmodload zsh/complist

zle -C complete-menu menu-select _generic

_complete_menu() {
    setopt localoptions alwayslastprompt
    zle complete-menu
}

zle -N _complete_menu

bindkey -M menuselect '/'  accept-and-infer-next-history
bindkey -M menuselect '^?' undo # ›backspace‹ key
bindkey -M menuselect ' ' accept-search
bindkey -M menuselect '*' history-incremental-search-forward
