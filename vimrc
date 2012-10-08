" .vimrc
" Curator: Laurens Duijvesteijn

" General ========================================================== {{{

	" Sets how many lines of history VIM has to remember
	set history=700

	" Enable filetype plugins
	filetype plugin on
	filetype indent on

	" Set to auto read when a file is changed from the outside
	set autoread

	" With a map leader it's possible to do extra key combinations
	" like <leader>w saves the current file
	let mapleader = ","
	let g:mapleader = ","

	" Disable vi compatability
	set nocompatible

	" Prevent modelines security exploits
	set modelines=0

	" Save when losing focus
	au FocusLost * :silent! wall

	" Make vim behave in a sane manner
	set encoding=utf-8
	set scrolloff=3
	set autoindent
	set showmode
	set showcmd
	set hidden
	set wildmenu
	set wildmode=list:longest
	set visualbell
	set cursorline
	set ttyfast
	set ruler
	set backspace=indent,eol,start
	set laststatus=2
	set relativenumber
	set undofile

" }}}

" Plugins ========================================================== {{{

	" Pathogen ----------------------------------------------------- {{

		" Load pathogen.vim
		runtime bundle/vim-pathogen/autoload/pathogen.vim

		" Initialize pathogen.vim
		call pathogen#infect()

		" Automatically generate documentation
		call pathogen#helptags()

	" }}

	" NERDTree ----------------------------------------------------- {{

		" Open NERDTree when vim starts up
		autocmd vimenter * if !argc() | NERDTree | endif

		" Show hidden files and folders
		let NERDTreeShowHidden=1

		" Set file filtering patterns
		let NERDTreeIgnore = ['\.DS_Store$', '\.un\~$', '\.swp$']

		" Close vim if only NERDTree is left open
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	" }}
	
	" Gundo -------------------------------------------------------- {{

		nnoremap <F5> :GundoToggle<CR>
	
	" }}
	
	" Ack ---------------------------------------------------------- {{
	
		" Bring up Ack
		nnoremap <leader>a :Ack!<space>	
	
	" }}

" }}}

" Text, tabs and indentation ======================================= {{{

	" Use spaces instead of tabs
	set noexpandtab

	" Be smart when using tabs ;)
	set smarttab

	" 1 tab == 4 spaces
	set shiftwidth=4
	set tabstop=4

	" Linebreak on 500 characters
	set lbr
	set tw=500

	set ai "Auto indent
	set si "Smart indent
	set wrap "Wrap lines

	" Text wrapping ------------------------------------------------ {{
	
		set wrap
		set textwidth=79
		set formatoptions=qrn1
		set colorcolumn=85	
	
	" }}

" }}}

" Input ============================================================ {{{

	" Disable arrow key movement ----------------------------------- {{
	
		nnoremap <up> <nop>
		nnoremap <down> <nop>
		nnoremap <left> <nop>
		nnoremap <right> <nop>
		inoremap <up> <nop>
		inoremap <down> <nop>
		inoremap <left> <nop>
		inoremap <right> <nop>
		nnoremap j gj
		nnoremap k gk	
	
	" }}

" }}}

" Convenience Mappings ============================================= {{{

	" Remap F1 to ESC
	inoremap <F1> <ESC>
	nnoremap <F1> <ESC>
	vnoremap <F1> <ESC>

	nnoremap ; :

	inoremap jj <ESC>

	" Easy buffer navigation
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l

" }}}

" Leader Mappings ================================================== {{{

	" Create a new vertical split and switch to it
	nnoremap <leader>w <C-w>v<C-w>l

" }}}

" VIM Environment (GUI/Console) ==================================== {{{

	" Enable syntax highlighting
	syntax enable

	" Use dark variant of color scheme
	set background=dark

	" Set colorscheme
	colors solarized
	
	" Set utf8 as standard encoding and en_US as the standard language
	set encoding=utf8

	" Use Unix as the standard file type
	set ffs=unix,dos,mac

	if has('gui_running')
		" GUI Vim

		set guifont=Menlo\ Regular:h13

		" Remove all the UI cruft
		set go-=T
		set go-=l
		set go-=L
		set go-=r
		set go-=R

		highlight SpellBad term=underline gui=undercurl guisp=Orange

		if has("gui_macvim")
			" Full screen means FULL screen
			set fuoptions=maxvert,maxhorz

			" Use the normal HIG movements, except for M-Up/Down
			let macvim_skip_cmd_opt_movement = 1
			no   <D-Left>       <Home>
			no!  <D-Left>       <Home>
			no   <M-Left>       <C-Left>
			no!  <M-Left>       <C-Left>

			no   <D-Right>      <End>
			no!  <D-Right>      <End>
			no   <M-Right>      <C-Right>
			no!  <M-Right>      <C-Right>

			no   <D-Up>         <C-Home>
			ino  <D-Up>         <C-Home>
			imap <M-Up>         <C-o>{

			no   <D-Down>       <C-End>
			ino  <D-Down>       <C-End>
			imap <M-Down>       <C-o>}

			imap <M-BS>         <C-w>
			inoremap <D-BS>     <esc>my0c`y
		else
			" Non-MacVim GUI, like Gvim
		end
	else
		" Console Vim
		" For me, this means iTerm2, possibly through tmux

		" Mouse support
		set mouse=a
		set t_Co=256
	endif

" }}}
