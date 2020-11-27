set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = "\\"

" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if isdirectory($HOME . "/.vim/bundle")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'terryma/vim-multiple-cursors'
    if v:version > 704 || (v:version == 704 && has( 'patch1578' ))
        " sudo yum install -y cmake && cd ~/.vim/bundle/YouCompleteMe && ./install.sh
        Plugin 'Valloric/YouCompleteMe'
    endif
    Plugin 'rust-lang/rust.vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-fugitive'
    Plugin 'vim-scripts/ReplaceWithRegister'
    Plugin 'machakann/vim-swap'
    Plugin 'python-mode/python-mode'

    call vundle#end()

    let g:ycm_autoclose_preview_window_after_completion = 1
endif

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
colorscheme peachpuff
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
map <Leader>c <Leader>lf
map [f :lfirst<CR>
map [n :lnext<CR>
map [p :lprev<CR>
map [l :llast<CR>
map <Leader>di i<C-R>=strftime("%Y-%m-%d %H:%M:%S UTC%z")<CR><Esc>hi:<Esc>ll
map <Leader>da a<C-R>=strftime("%Y-%m-%d %H:%M:%S UTC%z")<CR><Esc>hi:<Esc>ll

autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /\s\+$/

let g:pymode = 1
let g:pymode_indent = 1
let g:pymode_lint = 0
let g:pymode_breakpoint_bind = '<Leader>B'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore=W503,E129"
let g:syntastic_rst_checkers = []
let g:syntastic_rust_checkers = ['rustc']
let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
highlight SyntasticErrorSign guifg=white guibg=red
