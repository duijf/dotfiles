call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
call plug#end()

set nocompatible
set hidden

syntax on
colorscheme nord

set expandtab
set tabstop=4
set shiftwidth=4

let mapleader = ","

nnoremap <leader>ce :edit ~/.vimrc<CR>
nnoremap <leader>cs :source ~/.vimrc<CR>
