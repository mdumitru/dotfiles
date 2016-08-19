# GRML upstream
[[ -f ~/.zsh/grml-arch.zsh ]] && source ~/.zsh/grml-arch.zsh

# Antigen et plugins
export ADOTDIR=~/.zsh/.antigen-cache
export ZSH_CACHE_DIR=~/.zsh/.antigen-cache
[[ -f ~/.zsh/antigen-repo/antigen.zsh ]] && source ~/.zsh/antigen-repo/antigen.zsh

antigen bundle common-aliases
antigen bundle dirhistory
antigen bundle wd
antigen bundle z
antigen bundle sudo
antigen bundle git
antigen bundle fancy-ctrl-z
#antigen bundle last-working-dir
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
#antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen apply

# Vars, aliases
export LC_ALL="en_US.UTF-8"
export BROWSER='firefox'
export EDITOR='vi'
export XDG_CONFIG_HOME=$HOME/.config
export TERM=xterm-256color

if command -v vim > /dev/null; then
    export EDITOR='vim'
    alias vi='vim'
fi

if command -v nvim > /dev/null; then
    export EDITOR='nvim'
    alias vi='nvim'
    alias vim='nvim'

    neovim_autocd() {
        [[ $NVIM_LISTEN_ADDRESS ]] && ~/.scripts/nvim/neovim-autocd.py
    }
    chpwd_functions+=( neovim_autocd )
fi

weather() {
    if [[ $# == 0 ]]; then
        curl -4 "http://wttr.in/bucharest"
    else
        curl -4 "http://wttr.in/$1"
    fi
}

remake() {
    make clean || return $?
    if [[ $# == 0 ]]; then
        make
    else
        make $@
    fi
}

# needed by the wd plugin
wd() {
  . ~/bin/wd/wd.sh
}

# Zsh quick shorcut ref
zsh_hotkeys() {
cat << XXX
^a Beginning of line
^e End of line
^f Forward one character
^b Back one character
^h Delete one character
%f Forward one word
%b Back one word
^w Delete one word
^u Clear to beginning of line
^k Clear to end of line
^y Paste from Kill Ring
^t Swap cursor with previous character
%t Swap cursor with previous word
^p Previous line in history
^n Next line in history
^r Search backwards in history
^l Clear screen
^o Execute command but keep line
XXX
}

# Nvim as terminal multiplexer
if command -v nvim > /dev/null && \
    [[ -z $NVIM_LISTEN_ADDRESS ]]; then
        nvim -c "terminal"
fi

# Nvim host control
export PATH="$PATH:$HOME/.scripts/nvim"
if command -v nvim-host-cmd > /dev/null; then
    v() {
        if [[ $# == 0 ]]; then
            return 0;
        fi

        arg="$1"

        if [[ $# > 0 ]]; then
            shift
            for i in "$@"; do
                if [[ -f "$i" ]]; then
                    i=`realpath $i | sed 's/ /\\ /g'`
                fi
                arg="$arg $i"
            done
        fi
        nvim-host-cmd $arg
    }
    e() {
        if [[ $# == 1 ]]; then
            file=`realpath $1 | sed 's/ /\\ /g'`
        fi
        arg="edit $file"
        nvim-host-cmd $arg
    }
    tabe() {
        if [[ $# == 1 ]]; then
            file=`realpath $1 | sed 's/ /\\ /g'`
        fi
        arg="tabedit $file"
        nvim-host-cmd $arg
    }
    sp() {
        if [[ $# == 1 ]]; then
            file=`realpath $1 | sed 's/ /\\ /g'`
        fi
        arg="split $file"
        nvim-host-cmd $arg
    }
    vsp() {
        if [[ $# == 1 ]]; then
            file=`realpath $1 | sed 's/ /\\ /g'`
        fi
        arg="vsplit $file"
        nvim-host-cmd $arg
    }
    nerd() {
        if [[ $# == 1 ]]; then
            file=`realpath $1 | sed 's/ /\\ /g'`
        else
            file=`realpath .`
        fi
        arg='execute "Bdelete!" | NERDTree '$file
        nvim-host-cmd $arg
    }
fi

