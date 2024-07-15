set nocompatible

if exists('g:vscode')
    " VSCode extension
else
    lua require("nesneros")
endif

"Set leader to space
let mapleader=" "

set relativenumber
set backspace=indent,eol,start

"Sanity options
syntax on
set encoding=utf-8
set fileencoding=utf-8
set backspace=2
set number
set ruler
set wildmenu
set showmode
set showcmd
set guioptions=
set autoread
set autochdir
set matchpairs+=<:>

set noerrorbells
set visualbell

"So I can move around in insert
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj