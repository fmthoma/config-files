bindkey "^[[1;5C" vi-forward-word
bindkey "^[[1;5D" vi-backward-word

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
