#!/bin/bash

# Update PATH
# export PATH=/usr/local/sbin:/Applications//Postgres.app/Contents/Versions/9.5/bin/:$PATH
export PATH=/usr/local/sbin:$PATH

# Git Shortcuts
alias gs='git status'
alias gco='git checkout'
alias gb='/usr/local/bin/git branch'
alias lc="git log --name-status HEAD^..HEAD"

# Python / Foreman / Django Shortcuts
alias runserver='python manage.py runserver'
alias fs="foreman start"
alias fsd="foreman start -f Procfile.dev"

# Vagrant shortcuts
alias vgs='vagrant status'
alias vgd='vagrant destroy'

# Docker shortcuts
alias di='docker images'
alias dps='docker ps'

# Dotfile for vagrant
# export VAGRANT_DOTFILE_PATH=~/.vagrant

# Generic Aliases
alias rm='rm -i'
alias ll='ls -lah'
alias grep='grep --color'
alias genrandkeys='python -c "'"import random; print ''.join(random.sample(map(chr, range(48, 57) + range(97, 122)), 33))"'"'
alias sshnocheck='ssh -o StrictHostKeyChecking=no'
alias internet='mtr 12.0.1.28'
alias yamlint="python -c 'import yaml, sys; print yaml.load(sys.stdin)' <"

## Beautify Shell ##
export CLICOLOR=1
export WORKON_HOME=$HOME/.virtualenvs

# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Enable Virtualenv
source /usr/local/bin/virtualenvwrapper.sh
# Enable autoenv
source /usr/local/bin/activate.sh

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ in\ branch (\1)/'
}

C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"
export PS1="\n$C_PURPLE\u$C_DARKGRAY$C_DARKGRAY\$(parse_git_branch '$C_DARKGRAY [$C_GREEN%n:%b%m%u$C_DARKGRAY]') @ $C_BLUE\h$C_DARKGRAY in $C_LIGHTYELLOW\w\\n$C_DARKGRAY\$$C_DEFAULT"

### Added Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

encrypt() {
  # encrypt a file with auto generated password using aes256
  infile=$1
  if [[ $# -lt 1 ]]; then
    echo "Usage: encrypt filename"
    return 1
  fi
  if [[ ! -e $infile ]]; then
    echo "File $infile does not exist!"
    return 1
  fi
  outfile=$1.enc
  password=$(openssl rand -base64 6)
  openssl aes-256-cbc -a -salt -k $password -in $infile -out ${infile}.enc
  echo "Infile : $infile"
  echo "Password : $password"
  echo "Outfile : $outfile"
}

decrypt() {
  # decrypt a file with provided password
  if [[ $# -lt 2 ]]; then
    echo "Usage: decrypt filename password"
    return 1
  fi
  infile=$1
  if [[ ! -e $infile ]]; then
    echo "File $infile does not exist!"
    return 1
  fi
  password=$2
  outfile=$1.decrypted
  openssl aes-256-cbc -d -a -k $password -in $infile -out $outfile
  echo "Infile : $infile"
  echo "Outfile : $outfile"
}
