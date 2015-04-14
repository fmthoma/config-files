EXITCODE=$?

# synchronize history after each command
history -a
history -c
history -r

function __ps1() {

  function item() { # item fgColor bgColor text
    if [ -n "$3" ]
      then echo "\[$BGray$2\][\[$1$2\]$3\[$BGray$2\]]"
    fi
  }

  function length() { # length string
    PRINTING_CHARACTERS=$(echo "$1" | sed 's/\\\[[^]]*\\\]//g')
    echo ${#PRINTING_CHARACTERS}
  }

  function align() { # align left right
    SPACES=$(($COLUMNS-$(length "$1")-$(length "$2")))
    if [ $SPACES -lt 1 ]; then SPACES=1; fi
    printf "%s%${SPACES}s%s" "$1" "" "$2"
  }

  HISTORYITEM=$(history | tail -n1 | sed "s/\s*\([0-9]\+\).*/\1/")

  if [ ${EXITCODE:-0} -eq 0 ]
    then
      LASTCOMMAND="\[$BBlack$OnGreen\] !$HISTORYITEM \[$Reset\]"
    else
      LASTCOMMAND="\[$OnRed\] $EXITCODE !$HISTORYITEM \[$Reset\]"
  fi
  echo "$(align "" "$LASTCOMMAND")"

  # Time & Shell level
  if [ $SHLVL -gt 1 ]; then LVL="+$(($SHLVL-1))"; fi
  TIME=$(date '+%H:%M')
  NEXTHISTORYITEM=$(($HISTORYITEM+1))
  STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L "}$(item $BCyan  $OnBlack "$TIME $NEXTHISTORYITEM${LVL:+" $LVL"}")"

  # User@Host
  #STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L "}$(item $BGreen $OnBlack "\u@\h")"

  # PWD
  STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L "}$(item $BBlue  $OnBlack "$(pwd)")"

  # Git
  STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L "}$(item $BRed   $OnBlack "$(__git_ps1 '%s')")"

  # Stats
  MEMFREE=$( bc -l <<< "scale=1;`sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024/1024" )
  MEMTOTAL=$( bc -l <<< "scale=1;`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024/1024" )
  LOAD=$(cat /proc/loadavg)
  STATUSLINE_R="${STATUSLINE_R:+"$STATUSLINE_R "}$(item $Purple $OnBlack "$MEMFREE/${MEMTOTAL}GB | $LOAD")"

  STATUSLINE="$(align "$STATUSLINE_L" "$STATUSLINE_R\[$Reset\]")"
  echo "$STATUSLINE"
}

PROMPT="\[$BWhite$OnBlack\]▶ \[$Reset\]"

PS1="$(__ps1)\n$PROMPT"
PS2="$PROMPT"

