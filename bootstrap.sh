#!/bin/bash

#  |          |    |             /~~\|       ||
#  |~~\/~\/~\~|~(~~|~|/~\/~~||~~\`--.|/~\ /~/||
#  |__/\_/\_/ | _) | |   \__||__/\__/|   |\/_||
#                            |
# Installs dotfiles and sets zsh environment

# CONSTANTS
CURRENT_USER=$(logname)
USER_HOME=$(getent passwd $CURRENT_USER | cut -d: -f6)
SCRIPT_DIR=$(pwd)
SCRIPT_PREFIX="[bootstrap-shell] "
OH_MY_ZSH_URL="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
DOTFILES_REPO="https://github.com/mattdavenport/dotfiles"
BOOT_TOOLS="zsh vim tmux"
LINK_FILES=".vimrc .tmux.conf .zshrc"

# UTIL
print_info () {
  echo $(tput bold)$(tput setaf 4) $SCRIPT_PREFIX $@ $(tput sgr 0)
}

print_error ()  {
  echo $(tput bold)$(tput setaf 1) $SCRIPT_PREFIX $@ $(tput sgr 0)
}

print_prompt () {
  echo $(tput bold)$(tput setaf 9) $SCRIPT_PREFIX $@ $(tput sgr 0)
}

# Init
shopt -s nocasematch

# Install required tools
for tool in $BOOT_TOOLS; do
  if ! type "$tool" > /dev/null; then
    # Exit and re-run as sudo if apt needed
    if [[ $EUID -gt 0 ]]; then
      print_error "Sudo privileges required. Please re-run with sudo prefix."
      exit 1
    fi
    print_info "${tool} not installed, installing now..."
    apt-get install -y $tool
  fi
done

# Change default shell to zsh
print_info "Changing default shell to /bin/zsh..."
chsh -s /bin/zsh $CURRENT_USER

# Install oh-my-zsh
print_info "Installing oh-my-zsh..."
sh -c "$(curl -fsSL $OH_MY_ZSH_URL)"
rm $USER_HOME/.zshrc    # Remove pregen zshrc from oh-my-zsh

# Choose zsh theme
THEME_LIST=$(ls ~/.oh-my-zsh/themes | sed 's/\(.*\)\..*/\1/')
print_prompt "Please choose a oh-my-zsh theme (enter 'list-themes' for installed themes): "
read $theme
while [[ ! $THEME_LIST == *"$theme"* || $theme == "list-themes" ]]; do
  if [[ $theme == "list-themes" ]]; then
    echo $THEME_LIST | column
  else
    print_prompt "Invalid theme $theme, please enter a valid theme: "
    read $theme
  fi
done

# Set zsh theme
if [ -f $USER_HOME/.zsh_theme ]; then
  print_prompt ".zsh_theme currently set... override? (Yy/Nn)"
  read $remove_theme

  case "$remove_theme" in
    "n" ) print_info "Keeping old .zsh_theme";;
    * ) print_info "Removing old .zsh_theme"; echo $theme > $USER_HOME/.zsh_theme;;
  esac

fi

# Link files
for file in $LINK_FILES; do
  remove_file=Y
  if [ -f $USER_HOME/$file ]; then
    print_prompt "${file} exists already... override? (Yy/Nn)"
    read $remove_file
  fi

  case "$remove_file" in
    "n") print_info "Keeping existing file: ${file}";;
    * ) print_info "Linking ${file}"; ln -s $SCRIPT_DIR/$file $USER_HOME/$file;
  esac
done

# Install vim package
vim +PluginInstall +qall

# Set SSH multiplexing
# ref: http://frankenbyte.tumblr.com/post/33747851865/faster-github-using-ssh-multiplexing
SSH_DIR="$USER_HOME/.ssh"
[ -f "$SSH_DIR/config" ] || touch "$SSH_DIR/config" && mkdir "$SSH_DIR/connections"
cat > "$SSH_DIR/config" << EOL
Host *
  TCPKeepAlive yes
  ServerAliveInterval 60
  ControlMaster auto
  ControlPath ~/.ssh/connections/%r_%h_%p
EOL

# TODO - run `brew install reattach-to-user-namespace` if OSX for tmux conf
# TODO - Configure vim-youcompleteme
# TODO*** Install nodejs and `npm install -g typescript`
# TODO Setup PGP keys (keybase.io) and git signed commits
#sudo apt-get install -y build-essential cmake python-dev python3-dev
#cd $HOME/.vim/bundle/youcompleteme && ./install.py \
  #--clang-completer \
  #--tern-completer

# Source tmux
tmux source $USER_HOME/.tmux.conf
