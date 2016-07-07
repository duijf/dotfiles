" Neovim configuration
" Curator: Laurens Duijvesteijn

" Init & plugin install =========================================== {{{

  " Add dein installation to the runtimepath and set it's cache
  set runtimepath^=~/.dein
  call dein#begin(expand('~/.cache/dein'))

  " Motions
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('vim-scripts/tComment')
  call dein#add('bkad/CamelCaseMotion')

  " Completion and snippets
  call dein#add('tomtom/tlib_vim')
  call dein#add('marcweber/vim-addon-mw-utils')
  call dein#add('honza/vim-snippets')
  call dein#add('garbas/vim-snipmate')

  " Elixir
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('archSeer/elixir.nvim')
  call dein#add('mattn/emmet-vim')

  " Unite
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('Shougo/neomru.vim')

  " Colors
  call dein#add('tomelm/Smyck-Color-Scheme')

  " Tmux integration
  call dein#add('christoomey/vim-tmux-navigator')

  " Languages
  " NeoBundle 'ctrlpvim/ctrlp.vim'
  " NeoBundle 'Raimondi/delimitMate'
  " NeoBundle 'tpope/vim-fugitive'
  " NeoBundle 'terryma/vim-expand-region'
  " NeoBundle 'cohama/agit.vim'

  " Language plugins
  " NeoBundle 'sheerun/vim-polyglot'
  " NeoBundle 'csscomb/vim-csscomb'

  call dein#end()

  " Enable plugins and indent scripts
  filetype plugin indent on

" }}}

" Sane configuration ============================================== {{{

  " When scrolling, leave the bottom six lines free
  set scrolloff=6

  " Show commands as you type them
  set showcmd

  " Allow for hidden buffers
  set hidden

  " Use the wildmenu
  set wildmenu
  set wildmode=list:longest

  " Be fucking silent
  set visualbell

  " Smarter search settings
  set ignorecase
  set smartcase

  " More natural split opening
  set splitbelow
  set splitright

  " Use a persistent undo file
  set undofile

  " Disable line numbers
  set nonumber

  " Highlight the line the cursor is on
  set cursorline

  " Show the location in the file
  set ruler

  " Always show the status line
  set laststatus=2

  " Use spaces instead of tabs
  set expandtab

  " Be smart when using tabs
  set smarttab

  " Tab options
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
  set smartindent

  set textwidth=79
  set colorcolumn=79

  " Normal formatting and wrapping options
  set wrap
  set linebreak
  set nolist

  " Use Unix as the standard file type
  set ffs=unix,dos,mac

  " Force 256 color support
  set t_Co=256

" }}}


" Plugins ========================================================= {{{

  let g:deoplete#enable_at_startup = 1

  " " Toggle EasyMotion with space
  let g:EasyMotion_leader_key = '<space>'

  " Enable syntax highlighting
  syntax enable

  " Use dark variant of color scheme
  set background=dark

  " " Set colorscheme
  colorscheme smyck

" }}}

" Autocommands ==================================================== {{{

  " Automatically remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  " Markdown filetype
  au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd

  " Tabs and Makefiles
  autocmd FileType make setlocal noexpandtab

  " Automatically maximize help windows
  augroup filetype_help
    autocmd!
    autocmd BufWinEnter * if &l:buftype ==# 'help' | wincmd _ | endif
  augroup END

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

  " Make j and k function like normal on wrapped lines
  nnoremap j gj
  nnoremap k gk

  " Set the leader and localleader
  let mapleader = ","
  let g:mapleader = ","
  let maplocalleader = "\\"

  " Save when losing focus
  au FocusLost * :silent! wall

  " Open help in a vertical split

  " Easy buffer navigation
  noremap <C-h> <C-w>h
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l

  " Just <Tab> to switch buffers
  nmap <Tab> :bn<CR>
  nmap <S-Tab> :bp<CR>

  " <leader>d to write and close buffer, but keep the session
  nnoremap <C-w> :bd<CR>

  " Press enter to save file in normal mode
  nnoremap <CR> :write<CR>

  " Open neovim configuration
  nnoremap <leader>ev :e ~/.config/nvim/init.vim<cr>
  nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

  " Copy whole file to OS clipboard
  nnoremap <leader><leader>y ggVG"+y

  " Preserve indentation while pasting text from the system clipboard
  noremap <leader>p :set paste<CR>:put  +<CR>:set nopaste<CR>

  " Create a new vertical split and switch to it
  nnoremap <leader>vs <C-w>v<C-w>l

  " Clear search
  noremap <leader>c :let @/=""<CR>

  " Buffer resizing mappings
  nnoremap <leader>wn <C-w>=
  nnoremap <leader>wm <C-w>|
  nnoremap <leader>wc <C-w>o

  " Beginning and end of line with H and L
  nnoremap H ^
  nnoremap L $

  if has('nvim')
    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
  endif

  " Make w, b, e, and eg work with camel and snake case
  map <silent> w <Plug>CamelCaseMotion_w
  map <silent> b <Plug>CamelCaseMotion_b
  map <silent> e <Plug>CamelCaseMotion_e
  map <silent> ge <Plug>CamelCaseMotion_ge
  sunmap w
  sunmap b
  sunmap e
  sunmap ge

" }}}

" Unite =========================================================== {{{

  " Thanks to http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html

  " Enable yank history
  let g:unite_source_history_yank_enable = 1

  " Use the Unite fuzzy matcher
  call unite#filters#matcher_default#use(['matcher_fuzzy'])

  nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
  nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
  nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
  nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
  nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

  " Custom mappings for the unite buffer
  autocmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    " Exit unite
    nmap <buffer> <Esc> <Plug>(unite_all_exit)
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  endfunction

" }}}
