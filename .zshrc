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



##############
# Completion #
##############
setopt extendedglob
setopt nomatch

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/fthoma/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall



#############
# Delegates #
#############
. $DOTFILES/zsh/prompt.zsh
. $DOTFILES/zsh/alias.zsh
