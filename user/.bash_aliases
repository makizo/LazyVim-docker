
alias l='ls -CF'
alias ll='ls -l'     # long list
alias la='ls -A'     # all but . and ..
alias lsa='ls -a'
alias lla='ls -al'

alias x='exit'   # Exit shell

# Quickly edit dotfiles
alias eba='vim ~/dotfiles/.bash_aliases'
#alias bp='vim ~/.bash_profile'
alias ebr='vim ~/dotfiles/.bashrc'
alias ebc='vim ~/dev/cheatsheet/bash.cheat'
alias etc='vim ~/dotfiles/.tmux.conf'
alias evr='vim ~/dotfiles/.vimrc'
alias evc='vim ~/dev/cheatsheet/vim.cheat'
alias eac='vim ~/dev/cheatsheet/alacritty.cheat'
alias eic='vim ~/dev/cheatsheet/i3wm.cheat'
alias egc='vim ~/dev/cheatsheet/git.cheat'
#alias xr='vim ~/.xinitrc'

## Navigation ##
# Go backwards from current directory
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# Return to previous directory
alias b='cd - '
# Go to Dropbox folder
#alias db='cd ~/Dropbox'
# Go to Downloads folder
alias dl='cd ~/Downloads'
# Go to Desktop folder
alias dt='cd ~/Desktop'
# Go to GitHub clones folder
#alias ghc='cd ~/github/clones'
# Go to Github forks folder
#alias ghf='cd ~/github/forks'
# Go to Github repos folder
#alias ghr='cd ~/github/repos'
# Go to Home directory
alias h='cd ~/'
alias sbrc='source ~/.bashrc'

# easy command
alias dailydate='date +%Y/%m/%d'
alias di='vim ~/work/memo/personal/dailyMemo/daily.txt'
alias fusen='vim ~/work/memo/fusen.txt'
alias dailymental='vim /mnt/c/temporary/___memo/daily_mental.txt'
alias cookbook='vim /mnt/c/temporary/___memo/cookbook.txt'
alias vimcheat='vim -R ~/cheatsheet/vim.cheat'
alias alacrittycheat='vim -R ~/cheatsheet/alacritty.cheat'
alias bashcheat='more ~/cheatsheet/bash.cheat'
alias ferncheat='more ~/cheatsheet/fern.cheat'
alias gitcheat='more ~/cheatsheet/git.cheat'
alias tmuxcheat='more ~/cheatsheet/tmux.cheat'
alias scpcheat='more ~/cheatsheet/scp.cheat'
alias i3cheat='more ~/cheatsheet/i3wm.cheat'
alias pacmancheat='more ~/cheatsheet/pacman.cheat'
alias rangercheat='more ~/cheatsheet/ranger.cheat'
alias memobash='vim -R ~/_memo/memobash.txt'
alias sftpcheat='more ~/cheatsheet/sftp.cheat'
alias compresscheat='more ~/cheatsheet/compress.cheat'
alias cddev='cd ~/dev'
alias cdana='cd /mnt/c/Users/r34gt/ana_work'
alias df='df -h'
alias soba='source ~/.bashrc'
alias vimpure='vim -u NONE -U NONE NONE'
alias sba='source bin/activate'
alias rr='ranger'
alias mm='mupdf'
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
alias doil='docker image ls'
alias doir='docker image rm'
alias docl='docker container ls'
alias docla='docker container ls -a'
alias docr='docker container rm'
alias doih='docker image --help'
alias doch='docker container --help'
