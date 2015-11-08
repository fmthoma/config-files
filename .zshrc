export DOTFILES="$HOME/config-files"

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=999999
setopt appendhistory extendedglob nomatch notify
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/fthoma/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

. $DOTFILES/zsh/prompt.zsh
. $DOTFILES/zsh/alias.zsh
