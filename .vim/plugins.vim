" Plugin configurations
"
" All plugins here are sorted alphabetically (for lack of a better order), case
" insensitive ('Ab' comes before 'ac' but after 'aa'). Case-sorting should
" occur only as a secondary criteria ('nAme' comes before 'name').
"
" The description provided above the plugin is (usually) the short description
" from github and it should hopefully indicate the usefulness of a plugin.


" Attempt to source the plugin manager.
let s:manager_path=expand($HOME . "/.vim/autoload/plug.vim")
if ! filereadable(s:manager_path)
    finish
endif
exe 'source' s:manager_path


call plug#begin('~/.vim/plugins/')

" Recommended (for coloured icons) (by bufferline)
Plug 'nvim-tree/nvim-web-devicons'

"  A snazzy bufferline for Neovim 
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" Syntax highlighter for ANTLR files in vim
Plug 'dylon/vim-antlr'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'

" BufExplorer Plugin for Vim
Plug 'jlanzarotta/bufexplorer', { 'on': 'ToggleBufExplorer' }

" Vim syntax highlighting for c, bison, flex
Plug 'justinmk/vim-syntax-extra'

" A modern Vim and neovim filetype plugin for LaTeX files.
Plug 'lervag/vimtex'
let g:tex_flavor='latex'

" Delete buffers and close files in Vim without messing up your layout.
Plug 'moll/vim-bbye', { 'on': 'Bdelete' }

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Rename a buffer within Vim and on disk
Plug 'vim-scripts/Rename', { 'on': 'Rename' }

if has('nvim')
    " NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai. 
    Plug 'rebelot/kanagawa.nvim'
endif

" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'

" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" repeat.vim: enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" unimpaired.vim: pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" A vim plugin for toggling the display of the quickfix list and the location-list.
Plug 'Valloric/ListToggle'

" Allows one to edit a file with privileges from an unprivileged session.
Plug 'vim-scripts/sudo.vim'

" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'

" Swap your windows without ruining your layout
Plug 'wesQ3/vim-windowswap'

" Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-misc'

" Extended session management for Vim
Plug 'xolox/vim-session'


" Source 'local_plugins' file (if any).
" This file should contain only 'Plug' directives.
let s:local_plugins_path=expand($HOME . "/.vim/plugins/local_plugins.vim")
if filereadable(s:local_plugins_path)
    exe 'source' s:local_plugins_path
endif


call plug#end()

" load all plugin settings
let s:settings = expand($HOME . "/.vim/plugins-config/")
for fpath in split(globpath(s:settings, '*'), '\n')
    exe 'source ' fpath
endfor
