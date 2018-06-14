" TODO check if necessary.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after


" Source 'before' file (if any).
let vimbefore_path=expand($HOME . "/.vimrc.before")
if filereadable(vimbefore_path)
    exe 'source' vimbefore_path
endif


"------ Encoding settings ------
" Encoding in neovim is utf-8 by default and raises an error when resourcing.
if !has('nvim')
    set encoding=utf-8
endif

" Avoid an error when resourcing from an unmodifiable buffer.
if &modifiable
    set fileformats=unix,dos
endif


"------ General ------
set belloff=all         " don't ring the bell for any events
set foldlevel=9999      " unfold everything when opening a file
set foldmethod=indent   " define folds by indentation
set hidden              " don't unload buffers not open in any window
set history=9999        " remember these many commands and searches
set mouse=a             " enable mouse in normal, visual, insert, command-line
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

" Max nvim terminal scrollback.
let g:terminal_scrollback_buffer_size=100000


"------ Indents and tabs ------
set autoindent      " indent a newline using the current one's level

" Tabs are replaced with spaces, indentation is 4 characters.
set noexpandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4


"------ Console UI & Text display ------
set cursorline          " highlight the current line
set showcmd             " show partial command in the bot-right
set noshowmode          " the *line plugin should take care of this
set scrolloff=8         " start scrolling when within these many lines of edge
set report=0            " always report how many lines were changed
set shortmess=filmnrxI  " make sure exactly these options are set
set list                " display whitespaces
set showbreak=↪\        " mark visually wrapped lines
set listchars=tab:»\ ,trail:·,nbsp:␣
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
" Turn on syntax highlighting, keeping current settings.
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

" Don't allow keys that move the cursor left/right to move it between lines.
set whichwrap=


"------ Plugins config ------
" We need to set the map leader before Vundle loads plugins & their settings.
let mapleader="\<space>"


" Load all plugins.
let plugins_path=expand($HOME . "/.vim/plugins.vim")
if filereadable(plugins_path)
    exe 'source' plugins_path
endif


"------ User shortcuts, commands ------
nnoremap <silent> <c-s> :w!<cr>
nnoremap <silent> <leader>w :w!<cr>
cnoremap w!! SudoWrite sudo:%

" Make working with commands easier.
noremap ; :
noremap q; q:
noremap @; @:
noremap "; ":

" Easy-motion should be enough for navigation, but we still keep the
" functionality of the semicolon. The delay doesn't matter if you keep typing
" the command.
noremap ;; ;

" yy already exists to copy the whole line.
noremap Y y$

" The backtick is more useful but harder to reach.
noremap ' `
noremap ` '

" Quick replay 'q' macro and avoid Ex-mode.
noremap Q <nop>
nnoremap Q @q

" Disable select mode.
nnoremap gh <nop>

" Don't cancel visual select when shifting.
vnoremap < <gv
vnoremap > >gv

set pastetoggle=<f2>

" Some stuff breaks if $MYVIMRC is a symlink, so follow it.
command! Ev execute 'tabedit ' . resolve(expand($MYVIMRC))
command! Sv source $MYVIMRC

" Pressing * or # in visual mode searches for the current selection.
vnoremap * y/<c-r>"<cr>
vnoremap # y?<c-r>"<cr>

" Inspired by VimFX commands.
let g:__most_recent_tab=1
autocmd TabLeave * let g:__most_recent_tab=tabpagenr()
noremap <silent> g0 :tabrewind<cr>
noremap <silent> g$ :tablast<cr>
noremap <silent> gl :execute 'tabnext ' . g:__most_recent_tab<cr>

" Sometimes the color column is annoying.
function! _ToggleColorColumn()
    if &colorcolumn == ""
        if exists('b:__old_colorcolumn')
            let &colorcolumn=b:__old_colorcolumn
        else
            if &textwidth != 0
                let &colorcolumn=&textwidth+1
            else
                let &colorcolumn=81
            endif
        endif
    else
        let b:__old_colorcolumn=&colorcolumn
        let &colorcolumn=""
    endif
endfunction
command! -complete=command ToggleColorColumn call _ToggleColorColumn()

nnoremap <silent> <f3> :ToggleColorColumn<cr>

" Insert date at cursor poisiton.
nnoremap <silent> <f5> i<c-r>=substitute(system('date'),'[\r\n]*$','','')<cr><esc>
inoremap <silent> <f5> <c-r>=substitute(system('date'),'[\r\n]*$','','')<cr>


" Easy termbin copy/paste.
command! -range=% Tbcopy <line1>,<line2>write !netcat termbin.com 9999
command! -nargs=1 -range Tbpaste <line1>,<line2>!curl --silent termbin.com/<f-args>


"------ Global shortcuts ------
" Uniform mappings that can be used from neovim's terminal.

" Make it easy to close stuff (remember that 'hidden' is set).
noremap <silent> <a-backspace> :lclose<cr>:Bdelete<cr>
noremap <silent> <leader><backspace> :lclose<cr>:bdelete<cr>
" Note that :Bdelete is provided by a plugin.

noremap <silent> <a-n> :tabedit<cr>

" Both <f1> opening terminal help and highlighting are annoying.
noremap <silent> <f1> <esc>:nohlsearch<cr>

" Like windo but restore the current window and don't end in insert.
function! _Windo(command)
    let l:__current_window=winnr()
    execute 'windo ' . a:command
    stopinsert
    execute l:__current_window . 'wincmd w'
endfunction
command! -nargs=+ -complete=command Windo call _Windo(<q-args>)

" Toggle the line numbers of all windows in the current tab.
" On first use, it will turn them on.
" This is useful when debugging from a terminal split and you want to see line
" numbers in all visible source files.
function! _ToggleTabLineNumbers()
    if !exists('t:__old_linenumbers')
        let t:__old_linenumbers=0
    endif

    " Toggle numbers in modifiable, non-terminal windows.
    Windo if &modifiable && &buftype !~ "terminal" |
        \     let &number=!t:__old_linenumbers |
        \ endif

    let t:__old_linenumbers=!t:__old_linenumbers
endfunction
command! -complete=command ToggleTabLineNumbers call _ToggleTabLineNumbers()
nnoremap <silent> <f4> :ToggleTabLineNumbers<cr><esc>


if has('nvim')
    " Normal escape in terminal. Ctrl+Alt+e to send an Escape through.
    tnoremap <esc> <c-\><c-n>
    tnoremap <c-a-e> <esc>

    " Ensure we always end up in insert mode when going to a terminal buffer.
    autocmd TermOpen * if &buftype == 'terminal' | startinsert | endif
    autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | startinsert | endif
    autocmd BufLeave * if &buftype == 'terminal' | stopinsert | endif

    " Instantly close a terminal buffer when its process exits.
    " XXX This makes it impossible to work with non-interactive processes and
    " check their output.
    autocmd TermClose * bdelete!

    command! Tsplit split | terminal
    command! Tvsplit vsplit | terminal
    command! Ttabedit tabedit | terminal
    noremap <a-t> :Ttabedit<cr>
    tnoremap <a-t> <c-\><c-n>:Ttabedit<cr>
    tnoremap <a-n> <c-\><c-n>:tabedit<cr>
    tnoremap <silent> <c-a-q> <c-\><c-n>:q<cr>
    tnoremap <silent> <f1> <c-\><c-n>:nohlsearch<cr>gi

    " The BufEnter event is triggered, no need to return to insert explicitly.
    tnoremap <silent> <f4> <c-\><c-n>:ToggleTabLineNumbers<cr>
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


"------ Cscope ------
if has("cscope") && has("unix")
    function! _LoadCscope()
        set nocscopeverbose " suppress 'duplicate connection' error

        " Add database environment database (usually /fullpath/to/a/cscope.out).
        " Cscope is bad with symlinks, so resolve them.
        if $CSCOPE_DB != ""
            execute "cscope add ". resolve($CSCOPE_DB) . " " .
                        \ resolve(fnamemodify($CSCOPE_DB, ":p:h"))
        endif

        " Search cscope.out recursively in parent directories.
        if has("file_in_path") && has("path_extra")
            " Upwards search from cwd.
            let db = findfile("cscope.out", ".;")
            if !empty(db)
                let path = strpart(db, 0, match(db, "/cscope.out$"))
                execute "cscope add " . resolve(db) . " " . resolve(path)
            endif
        endif

        set cscopeverbose
    endfunction
    command! LoadCscope call _LoadCscope()

    " Automatically load cscope for these files.
    autocmd FileType c,cpp call _LoadCscope()

    " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'.
    set cscopetag
    set cscopetagorder=0  " use cscope first, then ctags

    " The 'silent' makes it so that pressing <Enter> is not required.
    nnoremap <silent> <leader>ss :silent cscope find s <c-r>=expand("<cword>")<cr><cr>
    nnoremap <silent> <leader>sg :silent cscope find g <c-r>=expand("<cword>")<cr><cr>
    nnoremap <silent> <leader>sc :silent cscope find c <c-r>=expand("<cword>")<cr><cr>
    nnoremap <silent> <leader>st :silent cscope find t <c-r>=expand("<cword>")<cr><cr>
    nnoremap <silent> <leader>se :silent cscope find e <c-r>=expand("<cword>")<cr><cr>
    nnoremap <silent> <leader>sf :silent cscope find f <c-r>=expand("<cfile>")<cr><cr>
    nnoremap <silent> <leader>si :silent cscope find i ^<c-r>=expand("<cfile>")<cr>$<cr>
    nnoremap <silent> <leader>sd :silent cscope find d <c-r>=expand("<cword>")<cr><cr>

    " Open a quickfix window for the following queries.
    set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,a-
endif


" Source 'after' file (if any).
let vimafter_path=expand($HOME . "/.vimrc.after")
if filereadable(vimafter_path)
    exe 'source' vimafter_path
endif
