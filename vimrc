set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = "\\"

" 1. http://www.vim.org/scripts/script.php?script_id=790
" 2. git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" 3. http://www.vim.org/scripts/script.php?script_id=974
if isdirectory($HOME . "/.vim/bundle")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'LycosaExplorer'
    Plugin 'nvie/vim-flake8'
    " sudo yum install -y cmake && cd ~/.vim/bundle/YouCompleteMe && ./install.sh
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'wting/rust.vim'

    call vundle#end()

    let g:ycm_autoclose_preview_window_after_completion = 1
    autocmd BufWriteCmd *.py call Flake8()
endif

syntax on
filetype indent plugin on
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on
set textwidth=79
colorscheme desert
set hidden
set number
set colorcolumn=80
set ls=2
set scrolloff=5
set incsearch
set wildmenu

nnoremap <silent> <Leader>/ :noh<CR>
imap <S-Space> <Esc>
nmap <Space> i<Space>
map <Leader>b <Leader>lb
map <Leader>f <Leader>lr

autocmd BufEnter * highlight BadWhitespace ctermbg=red guibg=red
autocmd BufEnter * match BadWhitespace /\s\+$/
