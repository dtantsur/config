set nocompatible              " be iMproved, required
filetype off                  " required
syntax off
let mapleader = "\\"

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if isdirectory($HOME . "/.vim/bundle")
    call plug#begin('~/.vim/bundle')

    Plug 'vim-syntastic/syntastic'
    Plug 'mg979/vim-visual-multi'
    if v:version > 800
        Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer --rust-completer' }
    endif
    Plug 'rust-lang/rust.vim'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'chaoren/vim-wordmotion'
    Plug 'machakann/vim-swap'
    Plug 'python-mode/python-mode'
    Plug 'fatih/vim-go'
    Plug 'gcmt/wildfire.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'tomasiser/vim-code-dark'

    call plug#end()

    if isdirectory($HOME . "/.vim/bundle/vim-code-dark")
        colorscheme codedark
        let g:airline_theme = 'codedark'
    endif
endif

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

nnoremap <silent> <Leader>' :noh<CR>
imap <S-Space> <Esc>
nmap <Space> i<Space>
map <Leader>f :GFilesNoVendor<CR>
map <Leader>b :Buffers<CR>
map <Leader>a :AgNoVendor<CR>
map <Leader>A :Ag<CR>
map <Leader>l :Lines<CR>
map <Leader>s :BLines<CR>
map [f :lfirst<CR>
map [n :lnext<CR>
map [p :lprev<CR>
map [l :llast<CR>
map <Leader>di i<C-R>=strftime("%Y-%m-%d %H:%M:%S UTC%z")<CR><Esc>hi:<Esc>ll
map <Leader>da a<C-R>=strftime("%Y-%m-%d %H:%M:%S UTC%z")<CR><Esc>hi:<Esc>ll
map <Leader>g :YcmCompleter GoTo<CR>
map <Leader>G :YcmCompleter GoToImplementation<CR>
map <Leader>c :YcmCompleter GoToCallers<CR>
map <Leader>d :YcmCompleter GetDoc<CR>
map <Leader>t :YcmCompleter GetType<CR>
map <Leader>F :YcmCompleter FixIt<CR>
map <Leader>R :YcmCompleter RefactorRename
map <Leader>Y :YcmRestartServer<CR>

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
let g:pymode_rope = 0
set completeopt=preview,menuone,noselect,noinsert
inoremap <expr> <CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rustup run stable rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]
let g:rustfmt_autosave = 1

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
hi Normal       ctermbg=NONE  guibg=NONE
hi CursorLineNr               guibg=NONE
hi EndOfBuffer                guibg=NONE
hi Folded                     guibg=NONE
hi LineNr       ctermbg=NONE  guibg=NONE
hi SignColumn   ctermbg=NONE  guibg=NONE

let g:wordmotion_uppercase_spaces = ['(', ')', "'", '"', ',', '.', '[', ']', ':', '=']

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

command! GFilesNoVendor
    \ call fzf#run(fzf#wrap({'source': 'git ls-files | egrep -v "(^|/)vendor/"', 'sink': 'e'}))
command! AgNoVendor
    \ call fzf#vim#ag(<q-args>, '--ignore vendor/ --ignore LICENSE --ignore go.sum', fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}))

let g:airline#extensions#tabline#enabled = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' ⮁ '

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
