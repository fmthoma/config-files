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

  function align() { # align left right fill_char=' '
    CHAR=${3:-" "}
    LEFT="$1"
    RIGHT="$2"
    SPACES=$(($COLUMNS-$(length "$LEFT")-$(length "$RIGHT")))
    if [ $SPACES -lt 1 ]; then RIGHT='' SPACES=$(($COLUMNS-$(length "$LEFT"))); fi
    echo "$LEFT$(printf "%${SPACES}s" "" | sed "s/\s/$CHAR/g")$RIGHT"
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
  STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L━"}$(item $BCyan  "" "$TIME $NEXTHISTORYITEM${LVL:+" $LVL"}")"

  # User@Host
  #STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L━"}$(item $BGreen "" "\u@\h")"

  # PWD
  STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L━"}$(item $BBlue  "" "$(pwd)")"

  # Git
  STATUSLINE_L="${STATUSLINE_L:+"$STATUSLINE_L━"}$(item $BRed   "" "$(__git_ps1 '%s')")"

  # Stats
  MEMFREE=$( bc -l <<< "scale=1;`sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024/1024" )
  MEMTOTAL=$( bc -l <<< "scale=1;`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024/1024" )
  LOAD=$(cat /proc/loadavg)
  STATUSLINE_R="${STATUSLINE_R:+"$STATUSLINE_R "}$(item $Purple "" "$MEMFREE/${MEMTOTAL}GB | $LOAD")"

  echo "$(align "$STATUSLINE_L" "$STATUSLINE_R\[$Reset\]" "━")"
}

PROMPT="\[$BWhite\]▶ \[$Reset\]"

PS1="$(__ps1)\n$PROMPT"
PS2="$PROMPT"
