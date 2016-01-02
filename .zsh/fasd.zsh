[ -d "$(dirname $0)/fasd" ] || return 1

source "$(dirname $0)/fasd/fasd"
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

alias a='fasd -a'
alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'

fasd_cd() {
 if [ $# -le 1 ]; then
   fasd "$@"
 else
   local _fasd_ret="$(fasd -e 'printf %s' "$@")"
   [ -z "$_fasd_ret" ] && return
   [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
 fi
}

alias j='fasd_cd -d'
