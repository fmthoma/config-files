# see http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html

autoload -Uz narrow-to-region

function _history-incremental-preserving-pattern-search-backward
{
    local state
    MARK=CURSOR  # magick, else multiple ^R don't work
    narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
    zle end-of-history
    zle history-incremental-pattern-search-backward
    narrow-to-region -R state
}

zle -N _history-incremental-preserving-pattern-search-backward

bindkey "^N" history-incremental-pattern-search-forward
bindkey "^R" _history-incremental-preserving-pattern-search-backward
bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey -M isearch "^M" accept-search # ›Enter‹ key
