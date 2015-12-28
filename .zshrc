bindkey -v
setopt notify
unsetopt autocd beep

for FILE in $(ls "$HOME/.zsh"); do
  . "$HOME/.zsh/$FILE"
done

export EDITOR=vim
export PAGER=less
