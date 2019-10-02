call plug#begin('~/.vim/plugged')
Plug 'LnL7/vim-nix'
Plug 'arcticicestudio/nord-vim'
Plug 'cespare/vim-toml'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
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
" modifications. The autoread option by itself is not enough. You need to
" make vim check. That's what the autocommand does.
set autoread
au FocusGained,BufEnter * :silent! !

set undodir=~/.vim/undo
set undofile

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <Space>s <Plug>(easymotion-overwin-f)
nmap <Space>w <Plug>(easymotion-overwin-w)
nmap <Space>r <Plug>(easymotion-lineanywhere)
nmap <Space>j <Plug>(easymotion-overwin-line)
