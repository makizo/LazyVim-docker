# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo
    echo
  done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
xterm* | rxvt* | Eterm* | aterm | kterm | gnome* | interix | konsole*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
  ;;
screen*)
  PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
  ;;
esac

use_color=true

if ${use_color}; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if type -P dircolors >/dev/null; then
    if [[ -f ~/.dir_colors ]]; then
      eval "$(dircolors -b ~/.dir_colors)"
    elif [[ -f /etc/DIR_COLORS ]]; then
      eval "$(dircolors -b /etc/DIR_COLORS)"
    fi
  fi

  if [[ ${EUID} == 0 ]]; then
    PS1='\[\033[01;31m\][\h\[\033[01;36m\] \w\[\033[01;31m\]]\$\[\033[00m\] '
  else
    PS1='\[\033[00;32m\]\u\[\033[00m\]@\[\033[00;32m\]\h\[\033[00;33m\] \W\[\033[00;36m\] \$\[\033[00m\] '
  fi
else
  if [[ ${EUID} == 0 ]]; then
    # show root@ when we don't have colors
    PS1='\u@\h \W \$ '
  else
    PS1='\u@\h \w \$ '
  fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root >/dev/null 2>&1

shopt -s expand_aliases

HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE=$'&:ls:la:ll:lla:diary:x:di'
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'
HISTCONTROL=ignoreboth
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi
export LANG=ja_JP.utf8

export MANPAGER='less -R'

# for yazi
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# for bash-completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# for history+fzf
function fh() {
  local selected_command
  selected_command=$(history |
    awk '{ cmd=$0; sub(/^[ ]*[0-9]+[ ]*/, "", cmd); print cmd }' |
    sort -nr |
    uniq |
    fzf --tac --no-sort --query "$READLINE_LINE" \
      --prompt="History > " \
      --preview 'echo {}' \
      --preview-window down:3:hidden:wrap \
      --bind '?:toggle-preview' \
      --bind 'ctrl-j:down' \
      --bind 'ctrl-k:up' \
      --bind 'ctrl-d:half-page-down' \
      --bind 'ctrl-u:half-page-up' \
      --bind 'alt-f:forward-word' \
      --bind 'alt-b:backward-word' \
      --bind 'alt-a:beginning-of-line' \
      --bind 'alt-e:end-of-line' \
      --bind 'alt-d:kill-word' \
      --bind 'alt-h:backward-kill-word' \
      --bind 'alt-p:preview-up' \
      --bind 'alt-n:preview-down' \
      --bind 'esc:abort')
  if [ -n "$selected_command" ]; then
    READLINE_LINE="$selected_command"
    READLINE_POINT=${#READLINE_LINE}
  fi
}

eval "$(zoxide init bash)"
