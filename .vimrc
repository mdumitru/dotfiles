" TODO check if necessary.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after


" Source 'before' file (if any).
let s:vimbefore_path=expand($HOME . "/.vimrc.before")
if filereadable(s:vimbefore_path)
    exe 'source' s:vimbefore_path
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
" older vims don't seem to support this, hence the 'silent!'
silent! set belloff=all

set foldlevel=9999
set foldmethod=indent
set hidden
set history=9999
set mouse=a

" this seems more intuitive, as that is how text works
set splitbelow
set splitright

set timeoutlen=500

" TODO cross-platform
if has('persistent_undo')
    silent !mkdir -p ~/.vim/temp_dirs/undodir > /dev/null 2>&1
    set undodir=~/.vim/temp_dirs/undodir
    set undofile
endif

" I cannot imagine why you wouldn't want this; copying from vim helps when
" searching functions/keywords etc. Copying to vim would be possible without
" sharing the system clipboard, but this makes it more uniform.
if has('clipboard')
    set clipboard=unnamed,unnamedplus
endif

filetype plugin indent on

if has('nvim')
    let g:terminal_scrollback_buffer_size=100000  " legacy
    set scrollback=100000
endif

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"------ Indents and tabs ------
set autoindent

" precisely because they can be set to any visual values, tabs are bad; we
" want control over how the file ends up looking
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4


"------ Console UI & Text display ------
set cursorline
set showcmd
set noshowmode          " the *line plugin should take care of this
set scrolloff=8
set report=0
set shortmess=cfilmnrxI
set list
set showbreak=↪\        " intentional trailing ws
set listchars=tab:»\ ,trail:·,nbsp:␣
set wildmenu
set wildmode=list:longest,full
set wildignorecase

" Ignore these files when autocompleting.
set wildignore=*.obj,*.o,*~,*.pyc
set wildignore+=__pycache__
set wildignore+=*.so,*.a,*.dll
set wildignore+=*.exe,*.com
set wildignore+=*DS_Store*
set wildignore+=.git/*,.hg/*,.svn/*


"------ Text editing and searching behavior ------
if !exists("g:syntax_on")
    syntax enable
endif

set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch
set matchtime=2
set textwidth=0
set formatoptions=tcroqnj

" intuitive backspace
set backspace=indent,eol,start

" Don't allow keys that move the cursor left/right to move it between lines.
set whichwrap=


"------ Plugins config ------
" We need to set the map leader before the plugin manager loads plugins &
" their settings.
let mapleader="\<space>"


" Load all plugins.
let s:plugins_path=expand($HOME . "/.vim/plugins.vim")
if filereadable(s:plugins_path)
    exe 'source' s:plugins_path
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

" select mode is unintuitive and useless
nnoremap gh <nop>

" don't cancel visual select when shifting; we should be able to use '.' even
" after the visual selection's gone, but sometimes it doesn't work...
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

" Insert date at cursor position.
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
    let l:_current_window=winnr()
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
    autocmd BufWinEnter,BufEnter,WinEnter * if &buftype == 'terminal' | startinsert | endif

    command! Tsplit split | terminal
    command! Tvsplit vsplit | terminal
    command! Ttabedit tabedit | terminal
    noremap <a-t> :Ttabedit<cr>
    tnoremap <a-t> <c-\><c-n>:Ttabedit<cr>
    tnoremap <a-n> <c-\><c-n>:tabedit<cr>
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


" Source 'after' file (if any).
let s:vimafter_path=expand($HOME . "/.vimrc.after")
if filereadable(s:vimafter_path)
    exe 'source' s:vimafter_path
endif
