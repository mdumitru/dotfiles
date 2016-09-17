if has("gui_running")
    gui
endif

let $LD_LIBRARY_PATH=''
set rtp^=~/.vim
set rtp+=~/.vim/after


"------ Vundle config ------
" Let Vundle load all the plugins from .vim/vundles.vim (if it exists)
let vundle_dir = expand($HOME . "/.vim/bundle/Vundle.vim")
let vundles_path = expand($HOME . "/.vim/vundles.vim")
if isdirectory(vundle_dir) && filereadable(vundles_path)
    exe 'source' vundles_path
endif


"------ Encoding settings ------
" encoding in nvim is utf-8 by default and throws an error when resourcing
if !has('nvim')
    set encoding=utf-8
endif

if !&modifiable
    set fileformats=unix,dos
    set fileformat=unix
endif


"------ General ------
set history=1000
set autoread
set mouse=a
set hidden
set noshowmode
set noerrorbells
set novisualbell
set timeoutlen=500
set splitbelow
set splitright
set exrc
set secure

" persistent undo
try
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry

" set clipboard to system clipboard
set clipboard=unnamed


"------ User shortcuts, commands ------
let mapleader=','
let g:mapleader=','

" :Sw saves the file as root
command! Sw w !sudo tee % > /dev/null

noremap <silent> <leader><cr> :noh<cr>
noremap <c-a> ggVG
nnoremap <c-s> :w!<cr>
nnoremap <leader>w :w!<cr>

" toggle folding
nnoremap <space> za

" paste mode
nnoremap <f2> :set invpaste paste?<cr>
set pastetoggle=<f2>

" some stuff breaks if $MYVIMRC is a symlink, so follow it
command! Ev execute 'tabedit ' . resolve(expand($MYVIMRC))
command! Sv source $MYVIMRC

command! ToggleColorColumn if &colorcolumn == '' | setlocal colorcolumn=81 | else | setlocal colorcolumn= | endif
noremap <a-c> :ToggleColorColumn<cr>


" Visual mode pressing * or # searches for the current selection
vnoremap * y/<c-R>"<cr> " forwards search
vnoremap # y?<c-R>"<cr> " backwards search

silent! tmap <esc> <c-\><c-n>
silent! tnoremap <c-a-e> <esc>

" Delete trailing white spaces (this takes out register y)
function! DeleteTrailingWS()
    exe "normal my"
    %s/\s\+$//ge
    exe "normal `y"
endfunction
nnoremap <leader>s :call DeleteTrailingWS()<cr>

if has('nvim')
    autocmd BufEnter * if &buftype == "terminal" | startinsert | endif
    command! Tsplit split term://$SHELL
    command! Tvsplit vsplit term://$SHELL
    command! Ttabedit tabedit term://$SHELL
endif


"------ Global shorcuts ------
noremap <a-n> :tabedit<cr>
noremap <a-q> :q<cr>
noremap <a-backspace> :Bd<cr>

if has ('nvim')
    noremap <a-r> cd:NERDTreeClose\|term<cr>
    noremap <a-t> :Ttabedit<cr>
    tnoremap <a-n> <c-\><c-n>:tabedit<cr>
    tnoremap <a-t> <c-\><c-n>:Ttabedit<cr>
    tnoremap <a-q> <c-\><c-n>:q<cr>
endif


"------ Navigation shortcuts ------
" treat long lines as multiple lines
noremap j gj
noremap k gk

noremap <a-h> <c-w>h
noremap <a-j> <c-w>j
noremap <a-k> <c-w>k
noremap <a-l> <c-w>l
noremap <a-i> gT
noremap <a-o> gt
noremap <c-a-i> :execute "tabmove" tabpagenr() - 2<cr>
noremap <c-a-o> :execute "tabmove" tabpagenr() + 1<cr>

if has ('nvim')
    tnoremap <a-h> <c-\><c-n><c-w>h
    tnoremap <a-j> <c-\><c-n><c-w>j
    tnoremap <a-k> <c-\><c-n><c-w>k
    tnoremap <a-l> <c-\><c-n><c-w>l
    tnoremap <a-i> <c-\><c-n>gT
    tnoremap <a-o> <c-\><c-n>gt
    tnoremap <c-a-i> <c-\><c-n>:execute "tabmove" tabpagenr() - 2<cr>
    tnoremap <c-a-o> <c-\><c-n>:execute "tabmove" tabpagenr() + 1<cr>
endif


"------ Backups ------
" no backups
set noswapfile
set nobackup
set nowb


"------ Console UI & Text display ------
set t_Co=256
syntax on

set showcmd
set number
set scrolloff=8
set report=0
set shortmess+=I
set list
set listchars=tab:»\ ,trail:·,extends:»,precedes:«
set wildmenu
set wildmode=list:longest

" ignore compiled files and executables
set wildignore=*.obj,*.o,*~,*.pyc,*.out,*.exe,*.com
if has('win16') || has('win32')
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif


"------ Text editing and searching behavior ------
set incsearch
set ignorecase
set smartcase
set nohlsearch
set showmatch
set matchtime=2
set backspace=eol,start,indent
autocmd BufNewFile,BufRead * setlocal textwidth=0
autocmd BufNewFile,BufRead * setlocal formatoptions=tcrq


"------ Indents and tabs ------
set foldcolumn=1
set foldlevelstart=99
set foldmethod=indent
set autoindent
set cindent
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4


"------ Language specific ------
autocmd BufNewFile,BufRead *.h setlocal filetype=c

