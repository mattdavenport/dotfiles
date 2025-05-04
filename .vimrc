" Automatically setup vim-plug on first run
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Set up vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" vimutil
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'tanvirtin/monokai.nvim'

Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'  " set working dir path when not specified

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{
      \ 'path': '~/Dropbox/Wiki/', 
      \ 'path_html': '~/Dropbox/Wiki/html',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \ 'index': 'index' }]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.wiki': 'markdown'}
let g:vimwiki_dir_link = 'index'

" theme
" Plug 'phanviet/vim-monokai-pro'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" codeutil
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/closetag.vim'
let g:graphql_javascript_tags = []

Plug 'scrooloose/nerdtree'
nmap <leader>ne :NERDTree<cr>

Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake'
" Run NeoMake on read and write operations
" ref: https://robots.thoughtbot.com/my-life-with-neovim
autocmd! BufReadPost,BufWritePost * Neomake

Plug 'jparise/vim-graphql'

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

Plug 'scrooloose/nerdcommenter'
Plug 'moll/vim-node'
Plug 'tpope/vim-rails'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'tpope/vim-sleuth'
Plug 'chr4/sslsecure.vim'
let g:vim_json_syntax_conceal = 0   " disable stupid JSON string quote hiding

" Markdown stuff
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

" End vim-plug
call plug#end()

filetype plugin indent on   " detect file type and load indents and plugins
syntax on                   " turn on syntax highlighting
"colorscheme monokai_pro     " syntax highlighting colours
"colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
colorscheme monokai


" Disable visual bell
set belloff=all

" Set dosini syntax highlighting for conf files
autocmd! BufRead,BufNewFile *.conf setf dosini

set autoread                " auto reload buffer when file modified externally
" clipboard setting causes errors on OSX
set clipboard=       " yank and paste using system clipboard
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

" Allow shift+TAB backwards tab behavior
" 1) For command mode
" 2) For insert mode
" nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

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
nnoremap <Leader>r :edit ~/.config/nvim/init.vim<CR>
nnoremap <Leader>R :source ~/.config/nvim/init.vim<CR>

" VIM-like tab navigation
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>

set guioptions=
set guifont=Menlo:h14

" Airline customizations
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
let g:airline_symbols.readonly = '⊛'

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
