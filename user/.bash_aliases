
alias l='ls -CF'
alias ll='ls -l'     # long list
alias la='ls -A'     # all but . and ..
alias lsa='ls -a'
alias lla='ls -al'

alias x='exit'   # Exit shell

#alias xr='vim ~/.xinitrc'

## Navigation ##
# Go backwards from current directory
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

alias sbrc='source ~/.bashrc'

#alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gb='git branch'
alias gbd='git branch -D'
alias gbm='git branch -m'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
# masterにcheckout、masterがなかったらmainにcheckout
alias gcom='git checkout master 2>/dev/null || git checkout main'
alias gd='git diff'
alias gl='git log'
alias glo='git log --oneline'
# masterをmerge、masterがなかったらmainをmerge
alias gmm='git merge master 2>/dev/null || git merge main'
alias gp='git push'
alias gpl='git pull'
alias gpo='git push origin'
alias gpuo='git push -u origin'
alias gs='git status'
alias gsa0='git stash apply stash@{0}'
alias gsl='git stash list'
alias gss='git stash save'
alias gsu='git stash save -u'
# for docker related
alias dils='docker image ls'
alias dirm='docker image rm'
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dcrm='docker container rm'
alias dcst='docker container start'
alias dcat='docker container attach'
alias dih='docker image --help'
alias dch='docker container --help'
