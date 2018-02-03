# vim:ft=zsh ts=2 sw=2 sts=2

CURRENT_BG='NONE'
PRIMARY_FG=black

# Characters
SEGMENT_SEPARATOR="\ue0b0"
SEGMENT_SEPARATOR_LIGHT="\ue0b1"
RSEGMENT_SEPARATOR="\ue0b2"
RSEGMENT_SEPARATOR_LIGHT="\ue0b3"
BRANCH="\uf418"
DETACHED="\uf417"
STAGED="\uf067 "
UNSTAGED="\uf069 "
AHEAD="\uf01b "
BEHIND="\uf01a "
CROSS="\u2718"
LIGHTNING="\uf0e7"
GEAR="\u2699"
CLOCK="\uf017 "
BATTERY_80="\uf240"
BATTERY_60="\uf241"
BATTERY_40="\uf242"
BATTERY_20="\uf243"
BATTERY_00="\uf244"

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $1 == $CURRENT_BG ]]; then
    print -n "%{%F{$PRIMARY_FG}%}$SEGMENT_SEPARATOR_LIGHT%{$fg%}"
  elif [[ $CURRENT_BG == 'NONE' ]]; then
    print -n "%{$bg%}%{$fg%}"
  else
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

rprompt_segment() {
  local fg bg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $1 == $CURRENT_BG ]]; then
    print -n "%{%F{$PRIMARY_FG}%}$RSEGMENT_SEPARATOR_LIGHT%{$fg%}"
  else
    print -n "%{%F{$1}%}$RSEGMENT_SEPARATOR%{$fg$bg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG='NONE'
}


prompt_context() {
  local shell_level current_time
  if [[ $SHLVL > 1 ]]; then shell_level=" +$(($SHLVL-1))"; fi
  current_time=$(date '+%H:%M')
  prompt_segment cyan $PRIMARY_FG " ${CLOCK}${current_time}${shell_level} "
}

rprompt_user() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    rprompt_segment $PRIMARY_FG default " %(!.%{%F{yellow}%}.)$user@%m "
  fi
}

prompt_git() {
  local color ref stashes

  ref="${vcs_info_msg_0_}"
  if [[ -n "$ref" ]]; then
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi

    if git status --porcelain 2> /dev/null | fgrep '??' &> /dev/null ; then
      ref+="$LIGHTNING"
    fi

    isDirty() {
      test -n "$(git status --porcelain --ignore-submodules 2> /dev/null | fgrep -v '??')"
    }
    isDirty && color=yellow || color=green

    stashes="$(git stash list 2> /dev/null | wc -l)"
    [[ $stashes > 0 ]] && ref+=" ${(l:$stashes:::)}"

    prompt_segment $color $PRIMARY_FG
    print -Pn " $ref "
  fi
}

prompt_git_remote() {
  local upstream remote ahead behind
  upstream=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
  ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if [[ -n $upstream ]]; then
    ahead=$(git rev-list @{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    behind=$(git rev-list HEAD..@{upstream} 2>/dev/null | wc -l | tr -d ' ')
    remote=${upstream/\/${ref}/}
    if [[ $behind > 0 ]] && [[ $ahead > 0 ]]; then
      prompt_segment red    $PRIMARY_FG " $remote $AHEAD$ahead $BEHIND$behind "
    elif [[ $behind > 0 ]]; then
      prompt_segment yellow $PRIMARY_FG " $remote $BEHIND$behind "
    elif [[ $ahead > 0 ]]; then
      prompt_segment green  $PRIMARY_FG " $remote $AHEAD$ahead "
    else
      prompt_segment green  $PRIMARY_FG " $remote "
    fi
  fi
}

prompt_dir() {
  prompt_segment blue $PRIMARY_FG " $(pwd) "
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"

  [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
}

rprompt_power() {
  local BAT=${1:-BAT0}
  local full now bat chr color
  full=$( cat "/sys/class/power_supply/$BAT/energy_full_design" )
  now=$(  cat "/sys/class/power_supply/$BAT/energy_now" )
  bat=$(( ($now * 100) / $full ))
  if   [[ $bat -gt 80 ]]; then chr=" $BATTERY_80 "
  elif [[ $bat -gt 60 ]]; then chr=" $BATTERY_60 "
  elif [[ $bat -gt 40 ]]; then chr=" $BATTERY_40 "
  elif [[ $bat -gt 20 ]]; then chr=" $BATTERY_20 "
  else                         chr=" $BATTERY_00 "
  fi

  [[ "$( cat "/sys/class/power_supply/$BAT/status" )" == "Charging"    ]] && chr="$chr$LIGHTNING"
  [[ "$( cat "/sys/class/power_supply/$BAT/status" )" == "Discharging" ]] && chr="$GEAR $chr"

  if   [[ $bat -gt 20 ]]; then color=green
  elif [[ $bat -gt  5 ]]; then color=yellow
  else                         color=red
  fi
  rprompt_segment $color $PRIMARY_FG " $chr $bat%% "
}

rprompt_stats() {
  local memfree memtotal load
  memfree=$( bc -l <<< "scale=1;`sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024/1024" )
  memtotal=$( bc -l <<< "scale=1;`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024/1024" )
  load=$(cat /proc/loadavg)
  rprompt_segment black white " $memfree/${memtotal}GB | $load "
}

build_prompt() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_git_remote
  prompt_end
  echo
  prompt_segment black white "  \ue175  "
  prompt_end
}

build_rprompt() {
  #rprompt_user
  rprompt_stats

  for BAT in $( ls /sys/class/power_supply/ | grep BAT ); do
    rprompt_power "$BAT"
  done
}

prompt_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(build_prompt) '
  RPROMPT='%{%f%b%k%}$(build_rprompt)'
}

prompt_setup() {
  setopt prompt_subst

  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:git*' stagedstr "$STAGED"
  zstyle ':vcs_info:git*' unstagedstr "$UNSTAGED"
  zstyle ':vcs_info:git*' formats '%b %c%u'
  zstyle ':vcs_info:git*' actionformats '%b %c%u (%a)'

  zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
}

prompt_setup "$@"
