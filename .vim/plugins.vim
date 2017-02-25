" Plugin configurations
"
" All plugins here are sorted alphabetically (for lack of a better order), case
" insensitive ('Ab' comes before 'ac' but after 'aa'). Case-sorting should
" occur only as a secondary criteria ('nAme' comes before 'name').
"
" The description provided above the plugin is (usually) the short description
" from github and it should hopefully indicate the usefulness of a plugin.


" Attempt to source the plugin manager.
let manager_path=expand($HOME . "/.vim/plugins/vim-plug/plug.vim")
if ! filereadable(manager_path)
    finish
endif
exe 'source' manager_path


call plug#begin('~/.vim/plugins/')

" Precision colorscheme for the vim text editor
Plug 'altercation/vim-colors-solarized'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'

" BufExplorer Plugin for Vim
Plug 'jlanzarotta/bufexplorer', { 'on': 'ToggleBufExplorer' }

" Vim syntax highlighting for c, bison, flex
Plug 'justinmk/vim-syntax-extra'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" Delete buffers and close files in Vim without messing up your layout.
Plug 'moll/vim-bbye', { 'on': 'Bdelete' }

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Flake8 plugin for Vim (python syntax & style checker)
Plug 'nvie/vim-flake8'

" Rename a buffer within Vim and on disk
Plug 'Rename', { 'on': 'Rename' }

" Use Vim as PAGER
Plug 'rkitover/vimpager'

" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'

" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" A tree file explorer plugin
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" repeat.vim: enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" unimpaired.vim: pairs of handy bracket mappings 
Plug 'tpope/vim-unimpaired'


" Load YCM only if it's available.
" See: https://github.com/Valloric/YouCompleteMe/issues/1558
if v:version + has('patch584') >= 704 && (has('python') || has('python3'))
    function! BuildYCM(info)
        " info is a dictionary with 3 fields
        " - name: name of the plugin
        " - status: 'installed', 'updated', or 'unchanged'
        " - force: set on PlugInstall! or PlugUpdate!
        if a:info.force
            !python install.py --all
        endif
    endfunction

    " A code-completion engine for Vim
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif


" AppleScript syntax highlighting
Plug 'vim-scripts/applescript.vim'

" An alternative indentation script for python
Plug 'vim-scripts/indentpython.vim'

" Allows one to edit a file with privileges from an unprivileged session.
Plug 'vim-scripts/sudo.vim'

" Lean & mean status/tabline for vim that's light as air
" install the font Hack to make it work properly:
" https://github.com/powerline/fonts/blob/master/Hack/
Plug 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" Swap your windows without ruining your layout
Plug 'wesQ3/vim-windowswap'

" Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-misc'

" Extended session management for Vim
Plug 'xolox/vim-session'

" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

call plug#end()


" load all plugin settings
let settings = expand($HOME . "/.vim/plugins.config/")
for fpath in split(globpath(settings, '*.vim'), '\n')
    exe 'source' fpath
endfor
