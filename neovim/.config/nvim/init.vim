call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'LnL7/vim-nix'
Plug 'elixir-editors/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
call plug#end()

" Colorscheme / highlighting.
colorscheme nord

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

" Briefly jump back to previous paren / brace when closing one.
" This makes it easy to gather context on what brace you're closing.
set showmatch

" Substitute all matches in a line by default.
set gdefault

" Make comments the same color as strings so they stand out more.
highlight Comment ctermfg=green

" Use 4 spaces instead of tabs by default.
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Use different indentation level for some filetypes.
autocmd FileType html,javascript,css,typescript,typescriptreact
  \ setlocal tabstop=2 softtabstop=2 shiftwidth=2

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
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

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

" Make <Tab> trigger a completion menu, and also use tab +
" shift tab to navigate through it.
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `ga` in normal mode to show the language server code actions menu.
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>

" Show a line diagnostic popup when nothing has been typed for 300ms.
set updatetime=300
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

lua <<EOF
-- Load the built in language server client.
local nvim_lsp = require('lspconfig')

-- Attach completion to a LSP client.
local on_attach = function(client)
    require('completion').on_attach(client)
end

-- Enable different language servers
require('rust-tools').setup({})
nvim_lsp.hls.setup({ on_attach=on_attach })
EOF
