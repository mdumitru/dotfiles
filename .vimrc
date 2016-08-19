if has("gui_running")
    gui
endif

let $LD_LIBRARY_PATH=''
set rtp^=~/.vim
set rtp+=~/.vim/after


"------ Vundle config ------
set nocompatible    " be iMproved
filetype off
if isdirectory($HOME . '/.vim/bundle/Vundle.vim')
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    "----- Plugins -----
    " Make gvim-only colorschemes work transparently in terminal vim
    Plugin 'godlygeek/csapprox'

    " precision color scheme for multiple applications with both dark/light modes
    Plugin 'altercation/solarized'
    Plugin 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=256

    " lean & mean status/tabline for vim that's light as air
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    " install Hack for powerline:
    " https://github.com/powerline/fonts/blob/master/Hack/Hack-Regular.ttf
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme = 'powerlineish'

    " Pasting in Vim with indentation adjusted to destination context
    Plugin 'sickill/vim-pasta'

    " Rename a buffer within Vim and on disk
    Plugin 'Rename'

    " BufExplorer Plugin for Vim
    Plugin 'jlanzarotta/bufexplorer'
    let g:bufExplorerDefaultHelp = 0
    let g:bufExplorerFindActive=0
    let g:bufExplorerShowRelativePath = 1
    let g:bufExplorerSortBy = 'name'

    "  A tree file explorer plugin
    Plugin 'scrooloose/nerdtree'
    let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
    let NERDTreeMapOpenInTab='t'

    " NERDTree and tabs together in Vim, painlessly
    Plugin 'jistr/vim-nerdtree-tabs'
    " let g:nerdtree_tabs_open_on_console_startup = 1

    " Vim plugin that displays tags in a window, ordered by scope
    Plugin 'majutsushi/tagbar'

    " a Git wrapper so awesome, it should be illegal
    Plugin 'tpope/vim-fugitive'

    " Vim plugin for intensely orgasmic commenting
    Plugin 'scrooloose/nerdcommenter'

    " Vim-Improved eMACS: Emacs emulation for Vim
    Plugin 'andrep/vimacs'
    let g:VM_Enabled=1
    " it breaks without this
    let g:VM_UnixConsoleMetaSendsEsc = 0

    " Delete buffers and close files in Vim without messing up your layout.
    Plugin 'moll/vim-bbye'

    " Swap your windows without ruining your layout
    Plugin 'wesQ3/vim-windowswap'

    " surround.vim: quoting/parenthesizing made simple
    Plugin 'tpope/vim-surround'

    " True Sublime Text style multiple selections for Vim
    Plugin 'terryma/vim-multiple-cursors'

    " Miscellaneous auto-load Vim scripts
    Plugin 'xolox/vim-misc'

    " Extended session management for Vim
    Plugin 'xolox/vim-session'
    let g:session_autosave='no'
    let g:session_autoload='no'
    let g:session_directory='~/.vimsessions'

    " An alternative indentation script for python
    Plugin 'vim-scripts/indentpython.vim'

    " Syntax checking hacks for vim
    Plugin 'scrooloose/syntastic'
    let g:syntastic_cpp_compiler_options = '-std=c++14 -Wall -Wextra'

    " Flake8 plugin for Vim (python syntax & style checker)
    Plugin 'nvie/vim-flake8'

    " AppleScript syntax highlighting
    Plugin 'vim-scripts/applescript.vim'

    call vundle#end()
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve
    "
    " see :h vundle for more details or wiki for FAQ
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
    silent !mkdir -p ~/.vim/temp_dirs/undodir >/dev/null 2>&1
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
catch
endtry


"------ User shortcuts, commands ------
let mapleader=','
let g:mapleader=','

" window swapper bindings
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>m :call WindowSwap#EasyWindowSwap()<cr>

" bufexplorer
noremap <A-b> :ToggleBufExplorer<cr>
if has ('nvim')
    tnoremap <A-b> <C-\><C-n>:ToggleBufExplorer<cr>
endif

" nerdtree
noremap <leader>nn :NERDTreeToggle<cr>
noremap <leader>nb :NERDTreeFromBookmark
noremap <leader>nf :NERDTreeFind<cr>

" tagbar
nnoremap <F8> :TagbarToggle<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W !sudo tee % > /dev/null

nnoremap <leader>w :w!<cr>
noremap <silent> <leader><cr> :noh<cr>
noremap <C-a> ggVG
noremap <C-s> :w!<cr>

" toggle folding
nnoremap <space> za

" paste mode
nnoremap <F2> :set invpaste paste?<cr>
set pastetoggle=<F2>

" some stuff breaks if $MYVIMRC is a symlink, so follow it
command! Ev execute 'tabedit ' . resolve(expand($MYVIMRC))
command! Sv source $MYVIMRC

command! ToggleColorColumn if &colorcolumn == '' | setlocal colorcolumn=81 | else | setlocal colorcolumn= | endif
noremap <A-c> :ToggleColorColumn<cr>


" Visual mode pressing * or # searches for the current selection
vnoremap * y/<C-R>"<cr> " forwards search
vnoremap # y?<C-R>"<cr> " backwards search

silent! tmap <Esc> <C-\><C-n>
silent! tnoremap <C-A-e> <Esc>

" Delete trailing white spaces (this takes out register z)
function! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction
nnoremap <leader>s :call DeleteTrailingWS()<cr>

if has('nvim')
    autocmd BufEnter * if &buftype == "terminal" | startinsert | endif
    command! Tsplit split term://$SHELL
    command! Tvsplit vsplit term://$SHELL
    command! Ttabedit tabedit term://$SHELL
endif


"------ Global shorcuts ------
noremap <A-n> :tabedit<cr>
noremap <A-q> :q<cr>
noremap <A-Backspace> :Bd<cr>
if has ('nvim')
    noremap <A-r> cd:NERDTreeClose\|term<cr>
    noremap <A-t> :Ttabedit<cr>
    tnoremap <A-n> <C-\><C-n>:tabedit<cr>
    tnoremap <A-t> <C-\><C-n>:Ttabedit<cr>
    tnoremap <A-q> <C-\><C-n>:q<cr>
endif


"------ Navigation shortcuts ------
" treat long lines as multiple lines
noremap j gj
noremap k gk

noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <A-i> gT
noremap <A-o> gt
noremap <C-A-i> :execute "tabmove" tabpagenr() - 2<cr>
noremap <C-A-o> :execute "tabmove" tabpagenr() + 1<cr>

if has ('nvim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    tnoremap <A-i> <C-\><C-n>gT
    tnoremap <A-o> <C-\><C-n>gt
    tnoremap <C-A-i> <C-\><C-n>:execute "tabmove" tabpagenr() - 2<cr>
    tnoremap <C-A-o> <C-\><C-n>:execute "tabmove" tabpagenr() + 1<cr>
endif


"------ Backups ------
" no backups
set noswapfile
set nobackup
set nowb

"------ Console UI & Text display ------
set t_Co=256
syntax on
set background=dark
colorscheme solarized

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

