#!/bin/bash

#  |          |    |             /~~\|       ||
#  |~~\/~\/~\~|~(~~|~|/~\/~~||~~\`--.|/~\ /~/||
#  |__/\_/\_/ | _) | |   \__||__/\__/|   |\/_||
#                            |
# Installs dotfiles and sets zsh environment
# Uses homemaker (github.com/foosoft/homemaker)

# CONSTANTS
CURRENT_USER=$(logname)
USER_HOME=$(getent passwd "$CURRENT_USER" | cut -d: -f6)
SCRIPT_DIR=$(dirname)
SCRIPT_PREFIX="[bootstrap-shell] "

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

# Check sudo
if [[ $EUID -gt 0 ]]; then
  print_error "Sudo privileges required. Please re-run with sudo prefix."
  exit 1
fi

# Install zsh & change default shell
print_info "Installing zsh..."
apt-get install -yq zsh

print_info "Changing default shell to /bin/zsh..."
chsh -s /bin/zsh

# Install oh-my-zsh
print_info "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
source $USER_HOME/.zshrc

# Set oh-my-zsh theme
THEME_LIST=$(ls ~/.oh-my-zsh/themes | sed 's/\(.*\)\..*/\1/')
print_prompt "Please choose a oh-my-zsh theme (enter 'list-themes' for installed themes): "
read $theme
while [[ ! $THEME_LIST == *"$theme"* || $theme == "list-themes" ]]; do
  if [[ $theme == "list-themes" ]]; then
    echo $THEME_LIST
  else
    print_prompt "Invalid theme $theme, please enter a valid theme: "
    read $theme
  fi
done

if [ -f $USER_HOME/.zsh_theme ]; then
  print_prompt ".zsh_theme currently set, override? (Yy/Nn)"
  read $remove_theme

  shopt -s nocasematch
  case "$remove_theme" in
    "n" ) print_info "Keeping old .zsh_theme";;
    * ) print_info "Removing old .zsh_theme"; echo $theme > $USER_HOME/.zsh_theme;;
  esac

fi

# Install goland
print_info "Installing golang..."
if [ ! -d $USER_HOME/.go ]; then
  mkdir $USER_HOME/.go
fi
apt-get install golang-stable

# Install dotfiles
print_info "Installing fresh shell..."
ln -s $SCRIPT_DIR/.freshrc /home/$CURRENT_USER/.freshrc

bash -c "`curl -sL https://get.freshshell.com`"

# Install vim
if ! type "vim" > /dev/null; then
  print_info "Vim not installed, installing now..."
  apt-get install vim
fi

# Install vim package
vim +PluginInstall +qall
