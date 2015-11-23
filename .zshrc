export DOTFILES="$HOME/config-files"

bindkey -v
setopt notify
unsetopt autocd beep

. $DOTFILES/zsh/history.zsh
. $DOTFILES/zsh/completion.zsh
. $DOTFILES/zsh/prompt.zsh
. $DOTFILES/zsh/alias.zsh
. $DOTFILES/zsh/menuselect.zsh
. $DOTFILES/zsh/historysearch.zsh
