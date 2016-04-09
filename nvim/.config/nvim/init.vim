" Neovim configuration
" Curator: Laurens Duijvesteijn

" Init & plugin install =========================================== {{{

  " Add dein installation to the runtimepath and set it's cache
  set runtimepath^=~/.dein
  call dein#begin(expand('~/.cache/dein'))

  " Manage dein with dein
  call dein#add('~/.dein')

  " Motions
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('tomtom/tlib_vim')
  call dein#add('vim-scripts/tComment')

  " Completion and snippets
  call dein#add('Shougo/deoplete.nvim')

  " Elixir
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('archSeer/elixir.nvim')

  " Colors
  call dein#add('chriskempson/base16-vim')

  " Languages
  " NeoBundle 'honza/vim-snippets'
  " NeoBundle 'ctrlpvim/ctrlp.vim'
  " NeoBundle 'Raimondi/delimitMate'
  " NeoBundle 'tpope/vim-fugitive'
  " NeoBundle 'terryma/vim-expand-region'
  " NeoBundle 'maxbrunsfeld/vim-yankstack'
  " NeoBundle 'terryma/vim-multiple-cursors'
  " NeoBundle 'cohama/agit.vim'
  "
  " " Appearance plugins
  " NeoBundle 'bling/vim-airline'
  " NeoBundle 'vim-airline/vim-airline-themes'
  " NeoBundle 'ryanoasis/vim-devicons'

  " " Language plugins
  " NeoBundle 'sheerun/vim-polyglot'
  " NeoBundle 'csscomb/vim-csscomb'
  " NeoBundle 'mattn/emmet-vim'
  "
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

  " Invisible character settings
  " set list
  " set listchars=tab:»,trail:·,eol:¬

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
  colorscheme base16-tomorrow

  " " Airline
  " let g:airline_powerline_fonts = 1
  " let g:airline_left_sep = ''
  " let g:airline_right_sep = ''
  " let g:airline_left_alt_sep = '⎢'
  " let g:airline_right_alt_sep = '⎢'
  " let g:airline_mode_map = {
  "                          \ '__' : '-',
  "                          \ 'n'  : 'N',
  "                          \ 'i'  : 'I',
  "                          \ 'R'  : 'R',
  "                          \ 'c'  : 'C',
  "                          \ 'v'  : 'V',
  "                          \ 'V'  : 'V-L',
  "                          \ 's'  : 'S',
  "                          \ 'S'  : 'S',
  "                          \}
  "
  " let g:airline#extensions#tabline#enabled = 1
  "
  " let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" }}}

" Autocommands ==================================================== {{{

  " Automatically remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  " Tab settings
  autocmd FileType html     setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType css      setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType plaintex setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  " markdown filetype file
  au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd

  " Tabs and Makefiles
  autocmd FileType make setlocal noexpandtab

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
  cnoremap help vert help

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

  " Moving lines up and down
  nnoremap <leader>- ddp
  nnoremap <leader>_ ddkP

  " Open neovim configuration
  nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
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

  " Run the current Elixir test file
  nnoremap <leader>t :!mix test --no-color %<CR>

  " Playback q register with backspace in normal and visual
  nnoremap <bs> @q
  vnoremap <silent> <bs> :norm @q<cr>

" }}}
