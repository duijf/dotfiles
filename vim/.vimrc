call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-vinegar'
call plug#end()

set nocompatible
set hidden
let mapleader = ","

set ignorecase
set smartcase

set incsearch
set hlsearch
set showmatch
noremap <leader><space> :let @/=""<CR>

set gdefault

syntax on
colorscheme nord

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set ttyfast

nnoremap <leader>ce :edit ~/.vimrc<CR>
nnoremap <leader>cs :source ~/.vimrc<CR>

nnoremap <CR> :w<CR>
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>

nnoremap j gj
nnoremap k gk

let g:rustfmt_autosave = 1

autocmd FileType haskell setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
