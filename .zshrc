# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH theme
ZSH_THEME="$(cat $HOME/.zsh_theme)"

# oh-my-zsh Plugins
plugins=(
          git
          rvm 
          bundler
          heroku 
          rails 
          rake 
          ruby 
          vagrant 
          docker 
          docker-compose 
          zsh-syntax-highlighting 
          tmux
          nvm
          pip
          npm
          node
          gulp
          python
          pyenv
          virtualenv
          django
          go
)

# User configuration
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:$HOME/.local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Options
setopt nonomatch    # fix weird globbing output

# Command Aliases

alias l='ls -hG --color'
alias ll='ls -lhG --color'
alias sl='ls -hG --color'
alias ls='ls -hG --color'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias k='kontena'
alias knssh='kontena node ssh -u root'
alias ssh-keygen='ssh-keygen -b 4096'
alias hs='head *'
alias tree='tree -C'
alias setup_docker_network='ifconfig lo0 alias 10.254.254.254'
alias docker-rmi-dangling='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-rmv-dangling='docker volume rm $(docker volume ls -qf dangling=true)'
alias mysqlmonitor="$HOME/.dotfiles/utils/mysql_monitor.sh"
alias ag='ag --color-match="3;31"'
alias git-date-branches="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"

# Set editor
if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

alias vi="$EDITOR -p"
alias vim="$EDITOR -p"

# reenable venv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=0

# NVM settings
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# GoLang vars
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$(go env GOPATH)/bin

# OSX
export PATH=$PATH:/opt/local/bin

# Kontena settings
export SSL_IGNORE_ERRORS=true
which kontena > /dev/null && . "$( kontena whoami --bash-completion-path )"

# Docker settings
[[ -f "$HOME/.config/docker-gc-exclude" ]] && export EXCLUDE_FROM_GC="$HOME/.config/docker-gc-exclude"

# SSH
if [[ -f ~/.ssh/.auto-agent ]]; then
  . ~/.dotfiles/ssh-find-agent.sh
  ssh-find-agent -a
  if [ -z "$SSH_AUTH_SOCK" ]
  then
     eval $(ssh-agent) > /dev/null
     ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'
  fi
fi

# zlib Config
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# Helper functions/aliases
alias whatsmyip='dig +short myip.opendns.com @resolver1.opendns.com'
alias nsps='netstat -plunt | sort'
alias git-stats='git shortlog -sn'
alias ipinfo='curl https://ipinfo.io'

# check open port on macOS
function check-port {
  [[ -n $1 ]] && lsof -n -i4TCP:$1 | grep LISTEN || echo "Port $1 is available for use!"
}

# Bump up the history!
export HISTSIZE=10000000

# start Kontena vpn
function kontena-vpn-start {
	set -e
	local pidfile=/var/run/kontena-openvpn.pid
	if [[ -s $pidfile ]] && [[ -f /proc/$(cat $pidfile)/stat ]]; then
      echo -n "Killing old openVPN process... "
      sudo kill -TERM $(cat $pidfile)
      while [[ -f /proc/$(cat $pidfile)/stat ]]; do sleep 1; done
      echo "Done"
	fi
    local tmpfile=$(mktemp -t openvpn.XXXXX)
    echo -n "Loading VPN config... "
    kontena vpn config "$@" > $tmpfile
    echo -n "Starting OpenVPN connection to $(awk '/^remote /{print $2}' $tmpfile)... "
    sudo openvpn --daemon --writepid $pidfile --config $tmpfile
    echo "Done"
    (sleep 5; rm $tmpfile; rm -f /tmp/openvpn.*)&
}

# send file to rtb
function readthenburn {
	[ -n "$1" ] || { echo "Usage: pass filename to upload file or use - to read stdin"; return 1; }
	[ "$1" = '-' ] && { secret='<-'; action=write; } || { secret="@$1"; action=upload; }
    url=$(curl -s -XPOST -F "secret=$secret" https://secure.bss-llc.com/readthenburn?action=$action)
    if [ $? -eq 0 -a $action = "write" ]; then echo "$url/raw"; else echo $url; fi
}

# source .profile for machine-specific settings
source ~/.profile

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source /Users/matt/Library/Preferences/org.dystroy.broot/launcher/bash/br
