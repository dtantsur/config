set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = "\\"

" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if isdirectory($HOME . "/.vim/bundle")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'mg979/vim-visual-multi'
    if v:version > 800
        " sudo yum install -y cmake && cd ~/.vim/bundle/YouCompleteMe && ./install.sh
        Plugin 'ycm-core/YouCompleteMe'
    endif
    Plugin 'rust-lang/rust.vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'tpope/vim-commentary'
    Plugin 'vim-scripts/ReplaceWithRegister'
    Plugin 'chaoren/vim-wordmotion'
    Plugin 'machakann/vim-swap'
    Plugin 'python-mode/python-mode'
    Plugin 'fatih/vim-go'

    call vundle#end()
endif

colorscheme peachpuff
syntax on
filetype indent plugin on
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
autocmd BufEnter *.yml setlocal softtabstop=2
autocmd BufEnter *.yml setlocal shiftwidth=2
autocmd BufEnter *.yaml setlocal softtabstop=2
autocmd BufEnter *.yaml setlocal shiftwidth=2
filetype indent on
set hidden
set number
set textwidth=79
set colorcolumn=80
autocmd BufEnter *.rs setlocal textwidth=100
autocmd BufEnter *.rs setlocal colorcolumn=101
set ls=2
set scrolloff=5
set incsearch
set wildmenu
if has('unnamedplus')
    set clipboard=unnamedplus
endif
set foldmethod=indent
set foldlevel=99

nnoremap <silent> <Leader>/ :noh<CR>
imap <S-Space> <Esc>
nmap <Space> i<Space>
map <Leader>f :GFiles<CR>
map <Leader>b :Buffers<CR>
map <Leader>a :Ag<CR>
map <Leader>l :Lines<CR>
map <Leader>s :BLines<CR>
map [f :lfirst<CR>
map [n :lnext<CR>
map [p :lprev<CR>
map [l :llast<CR>
map <Leader>di i<C-R>=strftime("%Y-%m-%d %H:%M:%S UTC%z")<CR><Esc>hi:<Esc>ll
map <Leader>da a<C-R>=strftime("%Y-%m-%d %H:%M:%S UTC%z")<CR><Esc>hi:<Esc>ll

let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<C-j>'
let g:VM_maps["Select Cursor Up"]   = '<C-k>'
let g:VM_maps["Select l"]   = '<C-l>'
let g:VM_maps["Select h"]   = '<C-h>'

autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /\s\+$/

let g:pymode = 1
let g:pymode_indent = 1
let g:pymode_lint = 0
let g:pymode_breakpoint_bind = '<Leader>B'
let g:pymode_rope = 1
set completeopt=preview,menuone,noselect,noinsert
inoremap <expr> <CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore=W503,E129,H238"
let g:syntastic_rst_checkers = []
" let g:syntastic_rust_checkers = ['rustc']
" let g:syntastic_rust_rustc_exe = 'cargo check'
" let g:syntastic_rust_rustc_fname = ''
" let g:syntastic_rust_rustc_args = '--'
highlight SyntasticWarning term=underline cterm=underline gui=underline
highlight SyntasticError term=underline cterm=underline gui=underline

let g:wordmotion_uppercase_spaces = ['(', ')', "'", '"', ',', '.', '[', ']', ':', '=']

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
