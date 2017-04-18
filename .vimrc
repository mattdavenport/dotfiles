" Automatically setup Vundle on first run
if !isdirectory(expand("~/.vim/bundle/vundle"))
    call system("git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle")
endif
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" vimutil
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'Lokaltog/vim-easymotion'

Bundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'  " set working dir path when not specified

" themes
Bundle 'nanotech/jellybeans.vim'
Bundle 'sickill/vim-monokai'
Bundle 'zacanger/angr.vim'

" codeutil
Bundle 'leafgarland/typescript-vim'
Bundle 'junegunn/vim-easy-align'
Bundle 'vim-scripts/closetag.vim'
Bundle 'othree/html5.vim'

Bundle 'scrooloose/nerdtree'
nmap <leader>ne :NERDTree<cr>

Bundle 'airblade/vim-gitgutter'
Bundle 'elixir-lang/vim-elixir'
Bundle 'lervag/vimtex'
Bundle 'mxw/vim-jsx'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-syntastic/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'stanangeloff/php.vim'
Bundle 'kylef/apiblueprint.vim'
Bundle 'moll/vim-node'
Bundle 'posva/vim-vue'
Bundle 'tpope/vim-rails'
Bundle 'vimwiki/vimwiki'
Bundle 'ekalinin/Dockerfile.vim'

" Automatically install bundles on first run
if !isdirectory(expand("~/.vim/bundle/vim-airline"))
    execute 'silent BundleInstall'
    execute 'silent q'
endif


filetype plugin indent on   " detect file type and load indents and plugins
syntax on                   " turn on syntax highlighting
colorscheme monokai         " syntax highlighting colours

set autoread                " auto reload buffer when file modified externally
" clipboard setting causes errors on OSX
"set clipboard=unnamed       " yank and paste using system clipboard
set encoding=utf-8          " default character encoding
set hidden                  " do not unload buffers that get hidden
set noswapfile              " do not use a swap file for buffers
set nowritebackup           " do not make backup before overwriting file

set laststatus=2            " always show the status line
set number                  " show line numbers
set scrolloff=3             " keep minimal number of lines above/below cursor
set showcmd                 " show command line at bottom of screen
set sidescroll=3            " scroll sideways 3 characters at a time
set splitright              " open vertical split right of current window
set visualbell              " use visual bell instead of beeping
set wildmenu                " tab auto-complete for commands
set wildignore=*.pyc        " stuff for auto-complete to ignore

set backspace=2             " make backspace behave normally
set expandtab               " insert tabs as spaces
set shiftwidth=2            " number of spaces for auto indent and line shift
set cindent                 " syntax-aware auto indent
set smarttab                " <BS> deletes a shiftwidth worth of space
set softtabstop=4           " number of spaces pressing <Tab> counts for
set tabstop=4               " number of spaces a <Tab> in the file counts for

set showmatch               " briefly jump to matching bracket
set ignorecase              " ignore case when pattern matching
set smartcase               " only if all characters are lower case
set incsearch               " highlight matches while typing search
set hlsearch                " keep previous search highlighted

" Turn off highlighting of previous search
noremap <C-n> :nohlsearch<CR>

let mapleader = ","
let g:mapleader = ","
let g:user_emmet_leader_key = '<C-e>'

imap jk <Esc>
noremap ; :

" Prevent overwriting default register (system clipboard) when inconvenient
vnoremap x "_x
vnoremap c "_c
vnoremap p "_dP

" Poor man's CtrlP
noremap <Leader>e :e **/*

" Move between open buffers easier
noremap <C-J> :bp<CR>
noremap <C-K> :bn<CR>
noremap <Leader>d :bd!<CR>:bp<CR>

" Move between vertical splits easier
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Git/fugitive shortcuts
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gf <C-W>h<C-W>czR
nnoremap <Leader>gp :Git push<CR>

" Mappings for misc plugins
map <SPACE> <Plug>(easymotion-s2)
map <Leader>a <Plug>(EasyAlign)
map <Leader>n :NERDTreeToggle<CR>

" Shortcuts to edit and reload vim config
nnoremap <Leader>r :edit ~/.vim/vimrc<CR>
nnoremap <Leader>R :source ~/.vim/vimrc<CR>:source ~/.vim/vimrc<CR>

" VIM-like tab navigation
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>

set guioptions=
set guifont=Menlo:h14

" Airline customizations
let g:airline_theme='serene'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒 '
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_skip_empty_sections = 1

" Closetag settings
let g:closetag_html_style=1
set bs=2

" HARD MODE
" " disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
