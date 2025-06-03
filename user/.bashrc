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
        echo; echo
    done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
        ;;
esac

use_color=true

# # Set colorful PS1 only on colorful terminals.
# # dircolors --print-database uses its own built-in database
# # instead of using /etc/DIR_COLORS.  Try to use the external file
# # first to take advantage of user additions.  Use internal bash
# # globbing instead of external grep binary.
# safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
# match_lhs=""
# [[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
# [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
# [[ -z ${match_lhs}    ]] \
#     && type -P dircolors >/dev/null \
#     && match_lhs=$(dircolors --print-database)
# [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval "$(dircolors -b ~/.dir_colors)"
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval "$(dircolors -b /etc/DIR_COLORS)"
        fi
    fi

    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\][\h\[\033[01;36m\] \w\[\033[01;31m\]]\$\[\033[00m\] '
    else
#         PS1='\[\033[01;32m\][\u@\h\[\033[01;33m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
#         PS1='\033[01;32m\][\u@\h]\[\033[01;33m\] \w\[\033[01;33m\]\n\[\033[01;36m\]\$\[\033[00m\] '
#         PS1='\033[00;32m\][\u@\h]\[\033[00;33m\] \w\[\033[00;33m\]\n\[\033[00;36m\]\$\[\033[00m\] '
#         PS1='\033[00;32m\][\u@\h]\[\033[00;33m\] \w\[\033[00;33m\]\[\033[00;36m\] \$\[\033[00m\] '
#         PS1='\033[00;32m\]\u@\h\[\033[00;33m\] \W\[\033[00;33m\]\[\033[00;36m\] \$\[\033[00m\] '
#         PS1='\033[00;32m\]\u@\h\[\033[00;33m\] \W\[\033[00;33m\]\[\033[00;36m\] \$\[\033[00m\] ' 
#         PS1='\[\033[00;32m\]\u@\h\[\033[00;33m\] \W\[\033[00;36m\] \$\[\033[00m\] '
        PS1='\[\033[00;32m\]\u\[\033[00m\]@\[\033[00;32m\]\h\[\033[00;33m\] \W\[\033[00;36m\] \$\[\033[00m\] '
    fi

    alias ls='ls --color=auto'
    alias grep='grep --colour=auto'
    alias egrep='egrep --colour=auto'
    alias fgrep='fgrep --colour=auto'
else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# --- makizo ---[2023/04/26]
# setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000
# makizo 23/08/28 :set histignore options
HISTIGNORE=$'&:ls:la:ll:lla:diary:x:di'
# Enable history appending instead of overwriting.  #139609
shopt -s histappend
PROMPT_COMMAND='history -a; history -n'

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
### from cygwin home
# base-files version 4.3-2
# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Programmable completion enhancements are enabled via
# /etc/profile.d/bash_completion.sh when the package bash_completetion
# is installed.  Any completions you add in ~/.bash_completion are
# sourced last.

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ---makizo---[2023/04/26]
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options.
HISTCONTROL=ignoreboth

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

# Some shortcuts for different directory listings
# --- makizo 2020/12/26 : comment for not using ls with -F option.
#alias ls='ls -hF --color=tty'                 # classify files in colour
# --- makizo 2020/12/26 : make alias for using ls with -h and -color option.
# --- makizo 2021/03/11 : return of -F option
alias ls='ls -hF --color=tty'
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#
# alias cd=cd_func

export LANG=ja_JP.utf8

mycrwl() {
  wget --tries=inf --timestamping --recursive --level=inf --convert-links --page-requisites --no-parent -R '\?C=' "$@"
}

###   ### for starting ssh-agent
###   env=~/.ssh/agent.env
###   
###   agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
###   
###   agent_start () {
###       (umask 077; ssh-agent >| "$env")
###       . "$env" >| /dev/null ; }
###   
###   agent_load_env
###   
###   # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
###   agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
###   
###   if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
###       agent_start
###       ssh-add
###   elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
###       ssh-add
###   fi
###   
###   unset env
###   ###

# ---makizo---[2023/04/26]
# for nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"    # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"    # This loads nvm bash_completion

# ---makizo---[2023/04/26]
# for node 
# ---makizo---[2024/07/29]: comment outed
# source /usr/share/nvm/init-nvm.sh

# ---makizo---[2023/04/26]
# for deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ---makizo---[2023/04/26]
# for fcitx input method on i3wm.
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

# ---makizo---[2023/04/26]
export EDITOR=vim
# ---makizo---[2023/12/30]
# ---makizo---[2024/07/29]: comment outed.
# export PATH="/home/makizo/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

# fzf related custom command
# ref. https://github.com/junegunn/fzf/wiki/Examples#changing-directory

# ffd - cd to selected directory
ffd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Another fd - cd into the selected directory
# This one differs from the above, by only showing the sub directories and not
#  showing the directories within those.
afd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Another CTRL-T script to select a directory and paste it into line
__fzf_select_dir ()
{
        builtin typeset READLINE_LINE_NEW="$(
                command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) \
                        -prune \
                        -o -type f -print \
                        -o -type d -print \
                        -o -type l -print 2>/dev/null \
                | command sed 1d \
                | command cut -b3- \
                | env fzf -m
        )"

        if
                [[ -n $READLINE_LINE_NEW ]]
        then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        else
                builtin bind '"\er":'
                builtin bind '"\e^":'
        fi
}

builtin bind -x '"\C-x1": __fzf_select_dir'
builtin bind '"\C-t": "\C-x1\e^\er"'

# sshf - select server name where ssh connect to.
sshf() {
    local sshLoginHost
# makizo:20240902: modify for ShellCheck
# sshLoginHost=`cat ~/.ssh/config | grep -i ^host | awk '{print $2}' | fzf`
    sshLoginHost=$(grep -i ^host < ~/.ssh/config | awk '{print $2}' | fzf)
    if [ "$sshLoginHost" = "" ]; then
        # ex) Ctrl-C.
        return 1
    fi

    ssh "${sshLoginHost}"
}

# set default opts for fzf
export FZF_DEFAULT_OPTS='--reverse --border'

## # export PAGER="/usr/local/bin/vim -R -c 'set ft=man nomod nolist' -c 'nnoremap q :q<CR>'"
## # export MANPAGER="vim -"
## export LESS_TERMCAP_mb=$'\E[1;31m'   # 赤色で強調表示
## export LESS_TERMCAP_md=$'\E[1;31m'   # 赤色で強調表示
## export LESS_TERMCAP_me=$'\E[0m'      # 強調解除
## export LESS_TERMCAP_se=$'\E[0m'      # 強調解除
## export LESS_TERMCAP_so=$'\E[1;44;33m' # 黄色の背景で青色の文字
## export LESS_TERMCAP_ue=$'\E[0m'      # 強調解除
## export LESS_TERMCAP_us=$'\E[4;32m'    # 緑色で下線表示
## # export PAGER=most
## man() {
##     env \
##         LESS_TERMCAP_mb=$(printf "\e[1;36m") \
##         LESS_TERMCAP_md=$(printf "\e[1;36m") \
##         LESS_TERMCAP_me=$(printf "\e[0m") \
##         LESS_TERMCAP_se=$(printf "\e[0m") \
##         LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
##         LESS_TERMCAP_ue=$(printf "\e[0m") \
##         LESS_TERMCAP_us=$(printf "\e[1;32m") \
##         man "$@"
## }
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

# export PAGER="sed -r 's/\x1B\[[0-9;]*[mGKH]//g' | vim -R -"

setxkbmap us

###   # makizo: add this function for completion clearly.
###   # 関数に対して '(func)' を付加し、エイリアスに '(alias)' を付加して補完
###   # カスタム補完関数
###   function _custom_completion() {
###       # bash-completion が有効な場合のみ実行
###       if declare -F _init_completion >/dev/null 2>&1; then
###           local cur prev words cword
###           _init_completion || return
###       else
###           local cur
###           cur="${COMP_WORDS[COMP_CWORD]}"
###       fi
###   
###       # 変数の宣言
###       local cmds
###       local functions
###       local aliases
###   
###       # 値の代入
###       cmds=$(compgen -c)              # 全コマンド一覧を取得
###       functions=$(compgen -A function) # 関数一覧を取得
###       aliases=$(compgen -A alias)      # エイリアス一覧を取得
###   
###       COMPREPLY=()
###       for cmd in $cmds; do
###           if [[ $functions =~ $cmd ]]; then
###               COMPREPLY+=("$cmd(func)")
###           elif [[ $aliases =~ $cmd ]]; then
###               COMPREPLY+=("$cmd(alias)")
###           else
###               COMPREPLY+=("$cmd")
###           fi
###       done
###   }
###   
###   # 任意のコマンド（例として "mycommand"）に対して補完関数を設定
###   complete -F _custom_completion

# カスタム補完関数を定義
function _my_custom_completion() {
    # 補完候補を設定
    COMPREPLY=("start" "stop" "restart")
}

# 関数を使って mycommand に対する補完を設定
complete -F _my_custom_completion mycommand

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# for bash-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# set default terminal to alacritty for thunar.
export TERMINAL=alacritty

# set TERM value.
export TERM=screen-256color

# for shell wrapper of yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# for history+fzf
function fh() {
    local selected_command
    selected_command=$(history | \
        awk '{ cmd=$0; sub(/^[ ]*[0-9]+[ ]*/, "", cmd); print cmd }' | \
        sort -nr | \
        uniq | \
        fzf --tac --no-sort\
            --query "$READLINE_LINE" \
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
# fh() {
#     local selected_command
#     selected_command=$(history | awk '{$1=""; print substr($0,2)}' | fzf --tac --no-sort --bind 'ctrl-j:down,ctrl-k:up,esc:abort')
#     if [ -n "$selected_command" ]; then
#         READLINE_LINE="$selected_command"
#         READLINE_POINT=${#READLINE_LINE}
#     fi
# }
bind -x '"\C-r": fh'

# for history+fzf
function ph() {
    local selected_command
    selected_command=$(history | \
        awk '{ cmd=$0; sub(/^[ ]*[0-9]+[ ]*/, "", cmd); print cmd }' | \
        sort -nr | \
        uniq | \
        peco)
    
    if [ -n "$selected_command" ]; then
        READLINE_LINE="$selected_command"
        READLINE_POINT=${#READLINE_LINE}
    fi
}
# for doxide: "MUST PUT ON LAST of THIS FILE"
eval "$(zoxide init bash)"

