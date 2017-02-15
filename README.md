# dotfiles
Dotfile repo for Linux dev boxes
Adapted from various sources:
  - ThoughtBot (thoughtbot/dotfiles)
  - spicycode  (https://gist.github.com/spicycode/1229612)
  - al-the-x   (al-the-x/homebrew-mine)

### Contents
1. .vimrc (VIM)
    * **Plugins**
        * *Vim Utility*
            * Vundle (Plug-in Manager)
            * Vim-Fugitive (Git wrapper)
            * Vim-Airline (Footer status line)
            * Vim-EasyMotion (VIM Motions)
        * *Code Utility*
            * Vim-Easy-Align (Code alignment)
            * Closetag.vim (Auto-tag completion)
            * Html5.vim (HTML5 omnicomplete)
            * NerdTree (File system explorer)
            * Vim-GitGutter (Git gutter)
            * Vim-Go (Golang support)
            * Vim-Elixir (Elixir support)
            * Vimtex (LaTeX support)
            * Vim-Jsx (JSX support)
            * Vim-Javascript (Improved JS support)
            * Syntastic (Syntax checker)
            * NerdCommenter (Commenting support)
            * Php.vim (PHP support)
    * **Themes**
        * Jellybeans
        * Vim-Monokai
2. .zshrc (Zshell)
3. .gemrc ('gem' config)
4. .rspec (rspec config)
5. .tmux  (tmux config & folder)

### Notes
* When using OSX, it is recommended that `coreutils` is installed. Once installed,
  the user will need to add `PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"`
  to the .profile file in order to map the GNU utils properly
