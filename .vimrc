" Vundle {{{
    set nocompatible              " be iMproved, required
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'kien/ctrlp.vim'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'crusoexia/vim-monokai'
    Plugin 'mhinz/vim-signify'
    Plugin 'lumiliet/vim-twig'
    Plugin 'valloric/youcompleteme'
    Plugin 'pangloss/vim-javascript'
    Plugin 'crusoexia/vim-javascript-lib'
    Plugin 'w0rp/ale'
    Plugin 'prettier/vim-prettier'
    Plugin 'Yggdroot/indentLine'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'yuttie/comfortable-motion.vim'
    " Plugin 'autozimu/LanguageClient-neovim'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
" }}}

" Misc {{{
    set encoding=utf-8

    let mapleader = ','
    set backspace=indent,eol,start      " Enable backspace wherever the hell I want
    set mouse=a                         " Enable mouse usage
    cabbrev tn tabnew                   " Shortcut for new vim tab

    set directory^=$HOME/.vim/swap//    " Place all vim swap files in same folder
    set runtimepath+=~/.vim-plugins/LanguageClient-neovim   " For LanguageClient-neovim installed in ~/.vim-plugins/
" }}}

" UI Layout {{{
    set number          " show line numbers
    set wildmenu        " visual autocomplete for command menu
    set lazyredraw      " redraw only when we need to
    set showmatch       " highlight matching brackets
    set showcmd         " Show commands in input area
" }}}

" Searching {{{
    " Case insensitive searching
    " Completely lowercase searches are case insensitive
    " Override with \c and \C
    set ignorecase
    set smartcase
    set hlsearch                                " Turn on highlighting for search
    set incsearch                               " Turn on incremental search
    nnoremap <leader><space> :nohlsearch<CR>    " Turn off search highlight

    " CTRL+P
    nnoremap <Leader>o :CtrlPMRUFiles<CR>       " Most Recently Used files
    let g:ctrlp_lazy_update = 1                 " Only search after typing has stopped

    " The SilverSearcher {{{
        if executable('ag')
            let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden
                        \ --ignore .git
                        \ --ignore .idea
                        \ --ignore /app
                        \ --ignore /bin
                        \ --ignore /ci
                        \ --ignore /vendor
                        \ --ignore /web
                        \ --ignore /gradle
                        \ --ignore /src-js/@accounts
                        \ --ignore /test
                        \ --ignore /test-ssgs
                        \ --ignore /test-trupi
                        \ --ignore /test-webservices
                        \ -g ""'
            set grepprg=ag\ --nogroup\ --nocolor  " Use ag over grep
            let g:ctrlp_use_caching = 0           " ag is fast enough that CtrlP doesn't need caching
        endif
" }}}

" }}}

" Spaces & Tabs {{{
    filetype plugin indent on
    set tabstop=4           " show existing tab with 4 spaces width
    set shiftwidth=4        " when indenting with '>', use 4 spaces width
    set expandtab           " On pressing tab, insert 4 spaces
" }}}

" Folding {{{
    set foldenable          " enable folding
    set foldlevelstart=10   " open most folds by default
    set foldnestmax=10      " 10 nested fold max
    set foldmethod=indent   " fold based on indent level
    nnoremap <space> za     " space open/closes folds
" }}}

" Fix Python Path (for YCM) {{{
    let g:ycm_path_to_python_interpreter='python'
    let g:ycm_server_python_interpreter='python'
" }}}

" Yank to clipboard {{{
    if has("clipboard")
        set clipboard=unnamed " copy to the system clipboard

        if has("unnamedplus") " X11 support
            set clipboard+=unnamedplus
        endif
    endif
" }}}

" Cursor Mode {{{
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
" }}}

" Colours {{{
    " enable correct colours in tmux {{{
        set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
        set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto
    " }}}

    " Airline Theme {{{
        let g:airline#extensions#syntastic#enabled = 1
        let g:airline_theme='solarized'
        let g:airline_powerline_fonts = 1               " Auto populate g:airline_symbols with powerline symbols
    " }}}

    " vim colors solarized {{{
        syntax enable
        set background=dark
        let g:solarized_visibility = 'high'
        let g:solarized_contrast = 'high'
        let g:solarized_termcolors=256
        colorscheme solarized
    " }}}
" }}}

" Ale {{{
    let g:airline#extensions#ale#enabled = 1
    let g:ale_linters = {'javascript': ['eslint']}
    let g:ale_fixers = {'javascript': ['prettier']}
    let g:ale_change_sign_column_color = 1          " Set highlights for the sign column when ALE reports problems

    " Close loclist automatically when buffer is closed
    augroup CloseLoclistWindowGroup
        autocmd!
        autocmd QuitPre * if empty(&buftype) | lclose | endif
    augroup END

    nmap <silent> <C-k> :lopen<cr>:wincmd p<cr>              " Open error list & switch back to original window
    nmap <silent> <leader>aj :ALENext<cr>                    " Next Error
    nmap <silent> <leader>ak :ALEPrevious<cr>                " Previous Error

" }}}

" NERDTree {{{
    let g:NERDTreeShowHidden=1
    let NERDTreeQuitOnOpen=1
    autocmd vimenter * wincmd p             " Jump to main window
    map <C-n> :NERDTreeFind<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif     " Close vim if only window open is a NERDTree
    set autochdir                           " Set working directory to active buffer
    let NERDTreeChDirMode=2                 " Checks that working directory works correctly
" }}}

" Custom Shortcuts {{{
    " Insert mode; Puts focus inside parentheses
    imap gll console.log(" = ", );<Esc>==f"a
    " Visual mode; Puts visual selection inside parentheses
    vmap gll y<ESC>ogll<Esc>pf,lp
    " Normal mode; Inserted on next line with word you're on inside parentheses
    nmap gll yiwogll<Esc>pf,lp
    " Visual mode; but removes the word and places it into a log
    vmap cll digll<ESC>pf,lp
" }}}

" Signify {{{
    let g:signify_vcs_list = [ 'git' ]      " Only activate for git
" }}}

" Prettier {{{
    let g:prettier#exec_cmd_async = 1
    let g:prettier#quickfix_auto_focus = 0
" }}}

" comfortable-motion.vim {{{
let g:comfortable_motion_friction = 0.0
let g:comfortable_motion_air_drag = 8.0
" }}}

" LSP {{{
   " Required for operations modifying multiple buffers like rename.
   set hidden

   let g:LanguageClient_serverCommands = {
       \ 'javascript':['/Users/ppoh/dotfiles/javascript-typescript-langserver/lib/language-server'],
       \ }

   nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
   nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
   nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}

" vim:foldmethod=marker:foldlevel=0
