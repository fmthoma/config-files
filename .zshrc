bindkey -v
setopt notify
unsetopt autocd beep

for FILE in $(ls .zsh); do
  . ".zsh/$FILE"
done
