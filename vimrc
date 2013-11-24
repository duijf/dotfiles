" .vimrc
" Curator: Laurens Duijvesteijn

" Init & plugin install =========================================== {{{

  if has('vim_starting')
    set runtimepath+=~/.lib/dotfiles/vim/bundle/neobundle.vim
  endif

  call neobundle#rc(expand('~/.lib/dotfiles/vim/bundle'))

  " Manage NeoBundle with NeoBundle
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Plugin declarations
  NeoBundle 'Shougo/vimproc', {
      \   'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'Lokaltog/vim-easymotion'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'bling/vim-airline'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'mattn/zencoding-vim'
  NeoBundle 'csscomb/CSScomb-for-Vim/'
  NeoBundle 'myusuf3/numbers.vim'
  NeoBundle 'vim-scripts/tComment'

  " Enable plugins and indent scripts
  filetype plugin on
  filetype indent on

" }}}

" Sane configuration ============================================== {{{

  " Behave as a normal editor
  set nocompatible

  " Make backspace work sanely
  set backspace=indent,eol,start

  " Sets how many lines of history VIM has to remember
  set history=700

  " UTF-8 encoding
  set encoding=utf-8

  " Set to auto read when a file is changed from the outside
  set autoread

  " Don't display the current mode (airline is used for that)
  set noshowmode

  " When scrolling, leave the bottom six lines free
  set scrolloff=6

  " Show commands as you type them
  set showcmd

  " Allow for hidden buffers
  set hidden

  " Use fast scrolling
  set ttyfast

  " Use the wildmenu
  set wildmenu
  set wildmode=list:longest

  " Be fucking silent
  set visualbell

  " Smarter search settings
  set incsearch
  set ignorecase
  set smartcase
  set hlsearch

  " More natural split opening
  set splitbelow
  set splitright

  " Use a persistent undo file
  set undofile

  " Use relative line numbers by default
  set relativenumber

  " Highlight the line the cursor is on
  set cursorline

  " Show the location in the file
  set ruler

  " Always show the status line
  set laststatus=2

  " Invisible character settings
  set list
  set listchars=tab:▸\ ,eol:¬

  " Use spaces instead of tabs
  set expandtab

  " Be smart when using tabs ;)
  set smarttab

  " 1 tab == 4 spaces
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2

  " Round indent to multiples of shiftwidth
  set shiftround

  " Linebreak on 500 characters
  set linebreak
  set textwidth=0
  set wrapmargin=0

  " Indentation and wrapping
  set autoindent
  set smartindent

  set textwidth=79
  set colorcolumn=85

  " Normal formatting and wrapping options
  set wrap
  set linebreak
  set nolist
  set formatoptions=qrn1

  " Use Unix as the standard file type
  set ffs=unix,dos,mac

" }}}


" Plugins ========================================================= {{{

  " Show hidden files and folders in NERDTree
  let NERDTreeShowHidden=1

  " Set NERDTree file filtering patterns
  let NERDTreeIgnore = ['\.DS_Store$', '\.un\~$', '\.swp$']

  " Toggle EasyMotion with space
  let g:EasyMotion_leader_key = '<space>'

  " Enable syntax highlighting
  syntax enable

  " Use dark variant of color scheme
  set background=dark

  " Set colorscheme
  let g:solarized_visibility = "low"
  colors solarized

  let g:airline_powerline_fonts = 1
  let g:airline_theme='solarized'

" }}}

" Autocommands ==================================================== {{{

  " Automatically remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  " Tab settings for HTML and CSS
  autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  " Tab settings for LaTeX
  autocmd FileType plaintex setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  " Automatically delete unused Fugitive buffers
  augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END

  " markdown filetype file
  au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd

" }}}

" Mappings ======================================================== {{{

  " No arrow keys!
  nnoremap <up> <nop>
  nnoremap <down> <nop>
  nnoremap <left> <nop>
  nnoremap <right> <nop>
  inoremap <up> <nop>
  inoremap <down> <nop>
  inoremap <left> <nop>
  inoremap <right> <nop>

  " Sane line switching with j and k
  nnoremap j gj
  nnoremap k gk

  " Set the leader and localleader
  let mapleader = ","
  let g:mapleader = ","
  let maplocalleader = "\\"

  " Save when losing focus
  au FocusLost * :silent! wall

  " Open help in a vertical split
  cnoremap help vert help

  " Easy buffer navigation
  noremap <C-h> <C-w>h
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l

  " Press enter to save file in normal mode
  nnoremap <CR> :write<CR>

  " Moving lines up and down
  nnoremap <leader>- ddp
  nnoremap <leader>_ ddkP

  " Open .vimrc
  nnoremap <leader>emv :vsplit ~/.lib/dotfiles/vim/vimrc<cr>
  nnoremap <leader>sv :source ~/.lib/dotfiles/vim/vimrc<cr>

  " Make OS level copy/paste work
  noremap <leader>y "*y
  noremap <leader>yy "*Y

  " Preserve indentation while pasting text from the OS X clipboard
  noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

  " Create a new vertical split and switch to it
  nnoremap <leader>vs <C-w>v<C-w>l

  " Clear search
  noremap <leader>c :let @/=""<CR>

  " Buffer resizing mappings
  nnoremap <leader>wn <C-w>=
  nnoremap <leader>wm <C-w>|
  nnoremap <leader>wc <C-w>o

  " Open a new buffer with Unite
  nnoremap <leader>ft :Unite file_rec/async -start-insert -auto-resize -default-action=tabopen<cr>
  nnoremap <leader>fv :Unite file_rec/async -start-insert -auto-resize -default-action=vsplit<cr>
  nnoremap <leader>fc :Unite file_rec/async -start-insert -no-split<cr>
  nnoremap <leader>bt :Unite buffer -default-action=tabopen<cr>
  nnoremap <leader>bv :Unite buffer -default-action=vsplit<cr>
  nnoremap <leader>bc :Unite buffer -no-split<cr>

" }}}

" VIM Environment (GUI/Console) =================================== {{{

  if has('gui_running')
    " Set the font
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12

    " Remove the toolbar
    set guioptions-=T

    " Remove the left scrollbars
    set guioptions-=l
    set guioptions-=L

    " Remove the right scrollbars
    set guioptions-=r
    set guioptions-=R

    if has("gui_macvim")
      " MacVim specific options

      " Full screen means FULL screen
      set fuoptions=maxvert,maxhorz

      " Disable the OS X like shortcuts in MacVim
      "let macvim_skip_cmd_opt_movement = 1
    else
      " Non-MacVim options

    end
  else
    " Console Vim settings

    " Mouse support
    set mouse=a

    " Force 256 color use.
    set t_Co=256

    " Disable vim-airline plugin in terminal due to bad color support in iTerm
    " set runtimepath-=~/.lib/dotfiles/vim/bundle/vim-airline
  endif

" }}}