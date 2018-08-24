set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'crusoexia/vim-monokai'
Plugin 'airblade/vim-gitgutter'
Plugin 'lumiliet/vim-twig'
Plugin 'valloric/youcompleteme'
Plugin 'pangloss/vim-javascript'
Plugin 'crusoexia/vim-javascript-lib'
" Plugin 'scrooloose/syntastic'
" Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'prettier/vim-prettier'
Plugin 'Yggdroot/indentLine'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

set encoding=utf-8
" Enable correct colours in tmux
set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto

" Case insensitive searching
" Completely lowercase searches are case insensitive
" Override with \c and \C
set ignorecase
set smartcase

" Turn on highlighting for search
set hlsearch

" Turn on incremental search
set incsearch

" Highlight line where the cursor is
set cursorline

" Show commands in input area
set showcmd
let mapleader = ','

" Enable backspace wherever the hell I want
set backspace=indent,eol,start

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']

" Fix Python Path (for YCM)
let g:ycm_path_to_python_interpreter='python'
let g:ycm_server_python_interpreter='python'

" Auto populate g:airline_symbols with powerline symbols
let g:airline_powerline_fonts = 1

" Airline theme
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='solarized'

" NERDTree
let g:NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
autocmd vimenter * NERDTree " Auto open on new vim instance 
autocmd vimenter * wincmd p " Jump to main window
map <C-n> :NERDTreeFind<CR>
" Close vim if only window open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
set autochdir " Set working directory to active buffer
let NERDTreeChDirMode=2 " Checks that working directory works correctly

" Ctrl-P
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_use_caching = 0

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/](\.git|node_modules)$'
            \ }

" Use relative numbering
set rnu
set nu

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Enable mouse usage
set mouse=a

" vim colors solarized
syntax enable
set background=dark
let g:solarized_visibility = 'high'
let g:solarized_contrast = 'high'
let g:solarized_termcolors=256
colorscheme solarized

" yank to clipboard
if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard

    if has("unnamedplus") " X11 support
        set clipboard+=unnamedplus
    endif
endif

" Change cursor mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Console log shortcuts
" Insert mode; Puts focus inside parentheses
imap gll console.log(" = ", );<Esc>==f"a
" Visual mode; Puts visual selection inside parentheses
vmap gll y<ESC>ogll<Esc>pf,lp
" Normal mode; Inserted on next line with word you're on inside parentheses
nmap gll yiwogll<Esc>pf,lp
" Visual mode; but removes the word and places it into a log
vmap cll digll<ESC>pf,lp

" Comment blocks of code
vmap cjs I//<ESC><ESC>
