" Neovim configuration
" Curator: Laurens Duijvesteijn

" Init & plugin install =========================================== {{{

  " Add dein installation to the runtimepath and set it's cache
  set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
  call dein#begin(expand('~/.cache/dein'))

  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Motions
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('vim-scripts/tComment')
  call dein#add('bkad/CamelCaseMotion')

  " Completion and snippets
  call dein#add('tomtom/tlib_vim')
  call dein#add('marcweber/vim-addon-mw-utils')
  call dein#add('honza/vim-snippets')
  call dein#add('garbas/vim-snipmate')

  " Languages
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('archSeer/elixir.nvim')
  call dein#add('mattn/emmet-vim')
  call dein#add('elmcast/elm-vim')
  call dein#add('vim-scripts/alex.vim')
  call dein#add('rust-lang/rust.vim')

  " Unite
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')

  " Colors
  call dein#add('tomelm/Smyck-Color-Scheme')

  " Tmux integration
  call dein#add('christoomey/vim-tmux-navigator')

  " Utilities
  call dein#add('junegunn/vim-easy-align')
  call dein#add('tpope/vim-fugitive')
  call dein#add('maxbrunsfeld/vim-yankstack')

  " Distration free writing
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/limelight.vim')

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

  " hindent options
  let g:hindent_line_length = 79

  " Autoformat Rust on save
  let g:rustfmt_autosave = 1

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

  augroup python
    au!
    autocmd FileType python set textwidth=99
    autocmd FileType python set colorcolumn=100
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

  " Search for selected text
  vnoremap // y/<C-R>"<CR>

  " Easy buffer navigation
  noremap <C-h> <C-w>h
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l

  " Just <Tab> to switch buffers
  nmap <Tab> :bn<CR>
  nmap <S-Tab> :bp<CR>

  " <leader>d to write and close buffer, but keep the session
  nnoremap <leader>d :bd<CR>

  " Press enter to save file in normal mode
  nnoremap <CR> :write<CR>

  " Quickly edit configuration
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

  " Seamless tmux pane switching
  if has('nvim')
    " Fix C-h in neovim. For more info see:
    " https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
  endif

  " Enable camelCaseMotion mappings
  call camelcasemotion#CreateMotionMappings('<leader>')

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

" }}}

" Unite =========================================================== {{{

  " Thanks to http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html

  " Enable yank history
  let g:unite_source_history_yank_enable = 1

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

" Appearance ====================================================== {{{

  " Change highlight color of vsplit to same as background
  hi VertSplit cterm=none ctermbg=none ctermfg=3

  " Status line largely stolen from Jorge Israel Peña
  " http://www.blaenkdenum.com/posts/a-simpler-vim-statusline/
  function! Status(winnum)
    let active = a:winnum == winnr()
    let bufnum = winbufnr(a:winnum)

    let stat = ''

    " this function just outputs the content colored by the
    " supplied colorgroup number, e.g. num = 2 -> User2
    " it only colors the input if the window is the currently
    " focused one

    function! Color(active, num, content)
      if a:active
        return '%' . a:num . '*' . a:content . '%*'
      else
        return a:content
      endif
    endfunction

    " this handles alternative statuslines
    let usealt = 0
    let altstat = Color(active, 4, ' »')

    let type = getbufvar(bufnum, '&buftype')
    let name = bufname(bufnum)

    if type ==# 'help'
      let altstat .= ' ' . fnamemodify(name, ':t:r')
      let usealt = 1
    endif

    if usealt
      let altstat .= Color(active, 4, ' «')
      return altstat
    endif

    function! Column()
      let vc = virtcol('.')
      let ruler_width = max([strlen(line('$')), (&numberwidth - 1)])
      let column_width = strlen(vc)
      let padding = ruler_width - column_width
      let column = ''

      if padding <= 0
        let column .= vc
      else
        " + 1 becuase for some reason vim eats one of the spaces
        let column .= vc . repeat(' ', padding)
      endif

      return column
    endfunction

    " This largely duplicates Column(), but I don't know enough about vimscript
    " to care.
    function! Line()
      let max_line = strlen(line('$'))
      let padding = max_line - strlen(line('.'))
      let line = ''

      if padding <= 0
        let line .= line('.')
      else
        " + 1 becuase for some reason vim eats one of the spaces
        let line .= repeat(' ', padding) . line('.')
      endif

      return line
    endfunction

    " file name
    let stat .= Color(active, 4, active ? ' »' : ' «')
    let stat .= ' %<'
    let stat .= '%f'
    let stat .= ' ' . Color(active, 4, active ? '«' : '»')

    " file modified
    let modified = getbufvar(bufnum, '&modified')
    let stat .= Color(active, 2, modified ? ' +' : '')

    " read only
    let readonly = getbufvar(bufnum, '&readonly')
    let stat .= Color(active, 2, readonly ? ' ‼' : '')

    " paste
    if active && &paste
      let stat .= ' %2*' . 'P' . '%*'
    endif

    " right side
    let stat .= '%='

    " git branch
    if exists('*fugitive#head')
      let head = fugitive#head()

      if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
        call fugitive#detect(getcwd())
        let head = fugitive#head()
      endif
    endif

    if !empty(head)
      let stat .= Color(active, 3, ' ← ') . head . ' '
    endif

    let stat .= '%1*'
    let stat .= '%{Line()}'
    let stat .= ':'
    let stat .= '%{Column()}'
    let stat .= '%*'

    return stat
  endfunction

  " Statusline autocommands
  function! s:RefreshStatus()
    for nr in range(1, winnr('$'))
      call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
    endfor
  endfunction

  augroup status
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
  augroup END

  " Statusline color tweaks
  hi StatusLine   ctermfg=7   ctermbg=236
  hi StatusLineNC ctermfg=8   ctermbg=236
  hi User1        ctermfg=8   ctermbg=236
  hi User2        ctermfg=125 ctermbg=236
  hi User3        ctermfg=64  ctermbg=236
  hi User4        ctermfg=10  ctermbg=236

  hi ColorColumn ctermbg=236

" }}}
