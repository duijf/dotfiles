call plug#begin('~/.local/share/nvim/plugged')
Plug 'LnL7/vim-nix'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-editors/vim-elixir'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'rust-lang/rust.vim'
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

" Make comments the same color as strings so they stand out more.
highlight Comment ctermfg=green

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Enable mouse support
set mouse=a

set ttyfast

nnoremap <leader>ce :edit ~/.config/nvim/init.vim<CR>
nnoremap <leader>cs :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>ts :%sort<CR>

nnoremap <CR> :w<CR>
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>

nnoremap j gj
nnoremap k gk

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <leader>f :RustFmt<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <leader>p :GFiles<CR>
let g:fzf_layout = { 'down': '100%' }

let g:typescript_indent_disable = 1

autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

autocmd BufWritePre * :%s/\s\+$//e

" Use `#` to search for the word under the cursor in all files using ripgrep.
"
" How to read this: we want to use `expand('<cword>')` to grep for the current
" word accross all files. However, this does not work on the ex command line.
" To evaluate the expression there, we use `<Ctrl-R>=` which prompts us for
" an expression to read from where we *can* use `expand()`. See
" `:help c_CTRL_R` for other options.
nnoremap # :Rg <C-r>=expand('<cword>')<CR><CR>
