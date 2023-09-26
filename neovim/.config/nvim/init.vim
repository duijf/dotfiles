call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'romgrk/barbar.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'nathangrigg/vim-beancount'
Plug 'LnL7/vim-nix'
Plug 'jvirtanen/vim-hcl'
Plug 'elixir-editors/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
call plug#end()

" Wishlist:
" - Get autocomplete to work properly.
" - Treesitter for syntax highlighting.
" - Make rust-analyzer's go to definition work with the Nix source
"   code.

" Colorscheme / highlighting.
colorscheme nord

" Use 24 bit colors
set termguicolors

" Leader key for custom shortcuts.
let mapleader = ","

" Make searches case-insensitive by default. When an upper case
" character is part of the search, do use case-sensitive search.
set ignorecase
set smartcase

" Start searching when the user starts typing. Highlight matches
" in the buffer while this is happening too.
set incsearch
set hlsearch

" Clear search highlighting.
noremap <leader><space> :let @/=""<CR>

" Remap :wq to save and close the buffer, not the editor. Make q
" close the buffer, not the editor. You can still exit with :quit.
command! SaveAndCloseBuffer :w | :bd
cnoreabbrev wq SaveAndCloseBuffer
cnoreabbrev q bd

" Briefly jump back to previous paren / brace when closing one.
" This makes it easy to gather context on what brace you're closing.
set showmatch

" Substitute all matches in a line by default.
set gdefault

" Use 4 spaces instead of tabs by default.
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use different indentation level for some filetypes.
autocmd FileType html,javascript,css,typescript,typescriptreact,haskell
  \ setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Persistent undo between sessions.
set undofile
set undodir=~/.local/share/nvim/undodir

" Disable automatic indentation for typescript.
let g:typescript_indent_disable = 1

" Remove trailing whitespace before saving a file.
autocmd BufWritePre * :%s/\s\+$//e

" Show line numbers, and merge the signcolumn with the number column.
" This removes jitter when warnings/errors appear due to e.g. IDE
" specific tools.
set signcolumn=number
set number

" Enable mouse support.
set mouse=a

" Quickly edit and reload this configuration file.
nnoremap <leader>ce :edit ~/.config/nvim/init.vim<CR>
nnoremap <leader>cs :source ~/.config/nvim/init.vim<CR>

" Write any changes to a file with ENTER.
nnoremap <CR> :w<CR>

" Flip between buffers with tab and shift tab.
nnoremap <silent> <S-Tab> :BufferPrevious<CR>
nnoremap <silent> <Tab> :BufferNext<CR>

nnoremap <leader>b :BufferPick<CR>

" Make line movement work accross visual lines, not buffer newlines by default.
nnoremap j gj
nnoremap k gk

" Search accross all git-tracked files easily.
nnoremap <leader>p :GFiles<CR>

" Disable GitGutter by default, but allow toggling
let g:gitgutter_enabled = 0
nnoremap <leader>gg :GitGutterToggle<CR>

" Ensure fzf takes up the entire screen.
let g:fzf_layout = { 'down': '100%' }

" Autoformat buffers with <,f>.
" TODO: add support for formatting other languages with the same mapping in
" other buffers.
nnoremap <leader>f :RustFmt<CR>

" BarBar config
let bufferline = get(g:, 'bufferline', {})

" Give all buffers without a name the same title.
let bufferline.no_name_title = "<new>"

" Settings to disable warnings + ugly icons. Don't need this.
let bufferline.icons = v:false
let bufferline.closable = v:false

" The animations are kind of janky and don't add much.
let bufferline.animation = v:false

" Make the highlighting work nicely with Nord.
highlight BufferCurrentMod guifg=#e5ab0e
highlight BufferInactiveMod guifg=#ad820c

" Use `#` to search for the word under the cursor in all files using ripgrep.
"
" How to read this: we want to use `expand('<cword>')` to grep for the current
" word accross all files. However, this does not work on the ex command line.
" To evaluate the expression there, we use `<Ctrl-R>=` which prompts us for
" an expression to read from where we *can* use `expand()`. See
" `:help c_CTRL_R` for other options.
nnoremap # :Rg <C-r>=expand('<cword>')<CR><CR>

" Better completion experience: always show a menu for completion options
" (menuone), do not insert completion suggestions automatically (noinsert,
" noselect).
set completeopt=menuone,noinsert,noselect

" Do not print stuff to the status bar when using completion.
set shortmess+=c

" Get docs + type definitions for symbol under cursor.
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" Jump to defniition
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>

lua <<EOF
-- Load the built in language server client.
local nvim_lsp = require('lspconfig')

-- Attach completion to a LSP client.
local on_attach = function(client)
    require('completion').on_attach(client)
end

-- Enable different language servers
require('rust-tools').setup({})
EOF
