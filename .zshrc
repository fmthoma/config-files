export DOTFILES="$HOME/config-files"

bindkey -v
setopt notify
unsetopt autocd beep



###########
# History #
###########
HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=999999
setopt appendhistory
setopt hist_ignoredups
setopt hist_ignorealldups
setopt hist_verify
setopt share_history



#############
# Delegates #
#############
. $DOTFILES/zsh/completion.zsh
. $DOTFILES/zsh/prompt.zsh
. $DOTFILES/zsh/alias.zsh
