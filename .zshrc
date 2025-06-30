# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH theme
ZSH_THEME="$(cat $HOME/.zsh_theme)"

# oh-my-zsh Plugins
plugins=(
          git
          bundler
          kubectl
          heroku 
          rails 
          rake 
          ruby 
          docker 
          zsh-syntax-highlighting 
          tmux
          pip
          npm
          node
          python
          ddev
)

# User configuration
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:$HOME/.local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Oh My Zsh
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
alias mysqlmonitor="$HOME/.dotfiles/utils/mysql_monitor.sh"
alias ag='rg'
alias git-date-branches="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"

# Set editor
if type "nvim" > /dev/null; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

alias vi="$EDITOR -p"
alias vim="$EDITOR -p"

# OSX
export PATH=$PATH:/opt/local/bin

# GPG
export GPG_TTY=$(tty)
export GPG_AGENT_INFO

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

# send file to rtb
function readthenburn {
	[ -n "$1" ] || { echo "Usage: pass filename to upload file or use - to read stdin"; return 1; }
	[ "$1" = '-' ] && { secret='<-'; action=write; } || { secret="@$1"; action=upload; }
    url=$(curl -s -XPOST -F "secret=$secret" https://readthenburn.arbolt.com/readthenburn?action=$action)
    if [ $? -eq 0 -a $action = "write" ]; then echo "$url/raw"; else echo $url; fi
}

# direnv
eval "$(direnv hook zsh)"

# source .profile for machine-specific settings
source ~/.profile

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval "$(mise activate zsh)"

source <(fzf --zsh)

export PAGER=less

# bit
case ":$PATH:" in
  *":/Users/mattdavenport/bin:"*) ;;
  *) export PATH="$PATH:/Users/mattdavenport/bin" ;;
esac
# bit end

# Nix profile
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

alias claude="/Users/mattdavenport/.claude/local/claude"
