" TODO check if necessary.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after


"------ Encoding settings ------
" Encoding in neovim is utf-8 by default and raises an error when resourcing.
if !has('nvim')
    set encoding=utf-8
endif

" Avoid an error when resourcing from unmodifiable buffer.
if &modifiable
    set fileformats=unix,dos
endif


"------ General ------
set nofoldenable        " unfold everything when opening a file
set foldmethod=indent   " define folds by indentation
set hidden              " don't unload buffers not open in any window
set history=9999        " remember these many commands and searches
set mouse=a             " enable mouse in normal, visual, insert, command-line
set noerrorbells        " never trigger an error sound
set novisualbell        " never trigger an error flash
set splitbelow          " a new horizontal split is placed below, not above
set splitright          " a new vertical split is placed to the right, not left
set timeoutlen=500      " wait these many milliseconds between a map's keys

" Set persistent undo.
" TODO cross-platform
if has('persistent_undo')
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
endif

" Set the clipboard to the system clipboard.
if has('clipboard')
    set clipboard=unnamed,unnamedplus
endif

" Enable filetype detection, scripts and indent-scripts.
filetype plugin indent on


"------ Indents and tabs ------
set autoindent      " indent a newline using the current one's level
set cindent         " use c-like indenting

" Tabs are replaced with spaces, indentation is 4 characters.
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4


"------ Console UI & Text display ------
set showcmd             " show partial command in the bot-right
set noshowmode          " the *line plugin should take care of this
set scrolloff=8         " start scrolling when within these many lines of edge
set report=0            " always report how many lines were changed
set shortmess=filmnrxI  " make sure exactly these options are set
set list                " display whitespaces
set listchars=tab:»\ ,trail:·   " symbols for whitespaces
set wildmenu                    " enable cycling through tab completion options
set wildmode=list:longest,full
set wildignorecase              " ignore case when autocompleting

" Ignore these files when autocompleting.
set wildignore=*.obj,*.o,*~,*.pyc
set wildignore+=__pycache__
set wildignore+=*.so,*.a,*.dll
set wildignore+=*.out,*.exe,*.com
set wildignore+=*DS_Store*
set wildignore+=.git/*,.hg/*,.svn/*


"------ Text editing and searching behavior ------
" turn on syntax highlighting, keeping current settings
if !exists("g:syntax_on")
    syntax enable
endif

set incsearch       " search as we type
set ignorecase      " make search case-insensitive
set smartcase       " make search case-sensitive if it contains upper-case chars
set hlsearch        " highlight search results
set showmatch       " highlight matching bracket
set matchtime=2     " tenths of a second to show the matching bracket
set textwidth=0     " don't wrap lines
set formatoptions=tcroqnj

" Allow backspace to delete indents, newlines and characters past insert-start.
set backspace=indent,eol,start

" Don't allow keys that move the cursor left right to move it between lines.
set whichwrap=


"------ Vundle config ------
" We need to set the map leader before Vundle loads plugins & their settings.
" Comment this line when using a decent layout (UK), so that the leader is '\'.
let mapleader=','


" Let Vundle load all the plugins from .vim/vundles.vim (if it exists).
let vundle_dir=expand($HOME . "/.vim/bundle/Vundle.vim")
let vundles_path=expand($HOME . "/.vim/vundles.vim")
if isdirectory(vundle_dir) && filereadable(vundles_path)
    exe 'source' vundles_path
endif


"------ User shortcuts, commands ------
nnoremap <c-s> :w!<cr>
nnoremap <leader>w :w!<cr>
cnoremap w!! SudoWrite sudo:%<cr>

" Make typing commands easier. Easy-motion should be enough for navigation, but
" we still keep the functionality of the semicolon.
noremap ; :
noremap : ;

" Quick replay 'q' macro and avoid Ex-mode.
noremap Q <nop>
nnoremap Q @q

" Reuse x as a proper delete.
noremap x "_d
nnoremap xx "_dd
noremap X "_D

" Disable select mode.
nnoremap gh <nop>

" Don't cancel visual select when shifting.
vnoremap < <gv
vnoremap > >gv

" Space toggles folds in normal mode (if any).
nnoremap <silent> <space> @=(foldlevel('.')?'za':"\<space>")<cr>

set pastetoggle=<f2>

" Some stuff breaks if $MYVIMRC is a symlink, so follow it.
command! Ev execute 'tabedit ' . resolve(expand($MYVIMRC))
command! Sv source $MYVIMRC

" Pressing * or # in visual mode searches for the current selection.
vnoremap * y/<c-r>"<cr>
vnoremap # y?<c-r>"<cr>

" Sometimes the color column is annoying.
command! ToggleColorColumn
            \ if &colorcolumn == "" |
            \   if exists('b:__old_colorcolumn') |
            \       let &colorcolumn=b:__old_colorcolumn |
            \   else |
            \       let &colorcolumn=81 |
            \   endif |
            \ else |
            \   let b:__old_colorcolumn=&colorcolumn |
            \   let &colorcolumn="" |
            \ endif
nnoremap <silent> <f3> :ToggleColorColumn<cr>

"------ Global shortcuts ------
" Uniform mappings that can be used from neovim's terminal.

" Make it easy to close stuff (remember that 'hidden' is set).
noremap <a-q> :q<cr>
noremap <a-backspace> :Bdelete<cr>
noremap <leader><backspace> :bdelete<cr>
" Note that :Bdelete is provided by a plugin.

noremap <a-n> :tabedit<cr>

" Both <f1> opening terminal help and highlighting are annoying.
noremap <silent> <f1> <esc>:nohlsearch<cr>

if has('nvim')
    tnoremap <esc> <c-\><c-n>
    tnoremap <c-a-e> <esc>

    " Always start insert when entering a terminal buffer.
    autocmd BufEnter * if &buftype == "terminal" | startinsert | endif

    command! Tsplit split | terminal
    command! Tvsplit vsplit | terminal
    command! Ttabedit tabedit | terminal
    noremap <a-t> :Ttabedit<cr>
    tnoremap <a-t> <c-\><c-n>:Ttabedit<cr>
    tnoremap <a-n> <c-\><c-n>:tabedit<cr>
    tnoremap <a-q> <c-\><c-n>:q<cr>
    tnoremap <silent> <f1> <c-\><c-n>:nohlsearch<cr>
endif


"------ Navigation shortcuts ------
" Treat visually wrapped lines as multiple lines.
noremap j gj
noremap k gk

" Swap functionalities with above.
noremap gj j
noremap gk k

" The following mappings help with moving between splits & tabs and moving tabs
" with the same shortcuts for regular and terminal buffers (if using nvim).
noremap <a-h> <c-w>h
noremap <a-j> <c-w>j
noremap <a-k> <c-w>k
noremap <a-l> <c-w>l
noremap <a-i> gT
noremap <a-o> gt
noremap <silent> <c-a-i> :execute "tabmove" tabpagenr() - 2<cr>
noremap <silent> <c-a-o> :execute "tabmove" tabpagenr() + 1<cr>

if has('nvim')
    tnoremap <a-h> <c-\><c-n><c-w>h
    tnoremap <a-j> <c-\><c-n><c-w>j
    tnoremap <a-k> <c-\><c-n><c-w>k
    tnoremap <a-l> <c-\><c-n><c-w>l
    tnoremap <a-i> <c-\><c-n>gT
    tnoremap <a-o> <c-\><c-n>gt
    tnoremap <silent> <c-a-i> <c-\><c-n>:execute "tabmove" tabpagenr() - 2<cr>
    tnoremap <silent> <c-a-o> <c-\><c-n>:execute "tabmove" tabpagenr() + 1<cr>
endif
