call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

set nocompatible
set hidden
let mapleader = ","

set ignorecase
set smartcase

syntax on
colorscheme nord

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4


nnoremap <leader>ce :edit ~/.vimrc<CR>
nnoremap <leader>cs :source ~/.vimrc<CR>

nnoremap <CR> :w<CR>
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>
