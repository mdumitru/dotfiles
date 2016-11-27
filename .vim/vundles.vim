" Vundle plugin configuration
"
" All plugins here are sorted alphabetically (for lack of a better order), case
" insensitive ('Ab' comes before 'ac' but after 'aa'). Case-sorting should
" occur only as a secondary criteria ('nAme' comes before 'name').
"
" The description provided above the plugin is (usually) the short description
" from github and it should hopefully indicate the usefulness of a plugin.

filetype off                  " required by vundle

set runtimepath+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/vundles/


call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Precision colorscheme for the vim text editor
Plugin 'altercation/vim-colors-solarized'

" Vim motions on speed!
Plugin 'easymotion/vim-easymotion'

" NERDTree and tabs together in Vim, painlessly
Plugin 'jistr/vim-nerdtree-tabs'

" BufExplorer Plugin for Vim
Plugin 'jlanzarotta/bufexplorer'

" Vim syntax highlighting for c, bison, flex
Plugin 'justinmk/vim-syntax-extra'

" Vim plugin that displays tags in a window, ordered by scope
Plugin 'majutsushi/tagbar'

" Delete buffers and close files in Vim without messing up your layout.
Plugin 'moll/vim-bbye'

" Better whitespace highlighting for Vim
Plugin 'ntpeters/vim-better-whitespace'

" Flake8 plugin for Vim (python syntax & style checker)
Plugin 'nvie/vim-flake8'

" Rename a buffer within Vim and on disk
Plugin 'Rename'

" Use Vim as PAGER
Plugin 'rkitover/vimpager'

" Pasting in Vim with indentation adjusted to destination context
Plugin 'sickill/vim-pasta'

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'

" A tree file explorer plugin
Plugin 'scrooloose/nerdtree'

" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'

" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'

" repeat.vim: enable repeating supported plugin maps with "."
Plugin 'tpope/vim-repeat'

" surround.vim: quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'

" unimpaired.vim: pairs of handy bracket mappings 
Plugin 'tpope/vim-unimpaired'

" A code-completion engine for Vim
Plugin 'Valloric/YouCompleteMe'

" AppleScript syntax highlighting
Plugin 'vim-scripts/applescript.vim'

" An alternative indentation script for python
Plugin 'vim-scripts/indentpython.vim'

" Allows one to edit a file with privileges from an unprivileged session.
Plugin 'vim-scripts/sudo.vim'

" Lean & mean status/tabline for vim that's light as air
" install the font Hack to make it work properly:
" https://github.com/powerline/fonts/blob/master/Hack/
Plugin 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plugin 'vim-airline/vim-airline-themes'

" Swap your windows without ruining your layout
Plugin 'wesQ3/vim-windowswap'

" Miscellaneous auto-load Vim scripts
Plugin 'xolox/vim-misc'

" Extended session management for Vim
Plugin 'xolox/vim-session'

" A plugin of NERDTree showing git status
Plugin 'Xuyuanp/nerdtree-git-plugin'

call vundle#end()


filetype plugin indent on    " required by vundle
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve
"
" see :h vundle for more details or wiki for FAQ


" load all plugin settings
let settings = expand($HOME . "/.vim/vundles.config/")
for fpath in split(globpath(settings, '*.vim'), '\n')
    exe 'source' fpath
endfor
