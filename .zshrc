# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH theme
ZSH_THEME="$(cat $HOME/.zsh_theme)"

# oh-my-zsh Plugins
plugins=(
          git
          rvm 
          heroku 
          rails 
          rake 
          ruby 
          vagrant 
          docker 
          docker-compose 
          zsh-syntax-highlighting 
          tmux
)

# User configuration
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

# Command Aliases
alias l='ls'
alias ll='ls -al'
alias sl='ls'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias k='kontena'
alias vi='vim'
alias knssh='kontena node ssh -u root'
alias howdoi='howdoi -ac'

# NVM settings
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export NVM_DIR="/home/kossae/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# GoLang vars
export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Kontena settings
export SSL_IGNORE_ERRORS=true
which kontena > /dev/null && . "$( kontena whoami --bash-completion-path )"

# SSH
# Automatically setup ssh agent if flag file exists
if [ -f ~/.ssh/.auto-agent ]; then
  # Allow cygwin to use PuTTY's pageant
  if [ -f /usr/bin/ssh-pageant ]; then
    eval $(/usr/bin/ssh-pageant -ra $TEMP/.ssh-pageant)
    echo "Using PuTTY's Pageant"
  # Use Linux ssh-agent
  elif [ -f /usr/bin/ssh-agent ] && [ -z "$SSH_AUTH_SOCK" ]; then
    for agent in /tmp/ssh-*/agent.*; do
      export SSH_AUTH_SOCK=$agent
      if ssh-add -l 2>&1 > /dev/null; then
        echo "Using already running ssh-agent"
        break
      else
        unset SSH_AUTH_SOCK
      fi
    done
    if [ -z "$SSH_AUTH_SOCK" ]; then
      eval $(ssh-agent)
      echo "Starting new ssh-agent"
      ssh-add
    fi
  fi
fi

# Helper functions/aliases
alias whatsmyip='dig +short myip.opendns.com @resolver1.opendns.com'
alias nsps='netstat -plunt | sort'

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
