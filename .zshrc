bindkey -v
setopt notify
unsetopt autocd beep

for FILE in $(ls "$HOME/.zsh/" | grep ".zsh$"); do
  . "$HOME/.zsh/$FILE"
done

# Make PATH entries unique
declare -U PATH

fpath+=$HOME/bin
