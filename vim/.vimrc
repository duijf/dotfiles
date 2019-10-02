call plug#begin('~/.vim/plugged')
Plug 'LnL7/vim-nix'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-commentary'
Plug 'tmux-plugins/vim-tmux-focus-events'
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
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


autocmd BufWritePre * %s/\s\+$//e

" Refresh files with changes from disk if the file does not contain
" modifications. Also auto write on focus lost.
set autoread
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * w
