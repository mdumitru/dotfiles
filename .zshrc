# GRML upstream
[[ -f ~/.zsh/grml-arch.zsh ]] && source ~/.zsh/grml-arch.zsh

# Antigen plugins
export ADOTDIR=~/.zsh/.antigen-cache
export ZSH_CACHE_DIR=~/.zsh/.antigen-cache
[[ -f ~/.zsh/antigen-repo/antigen.zsh ]] && source ~/.zsh/antigen-repo/antigen.zsh

antigen bundle common-aliases
antigen bundle dirhistory
antigen bundle fancy-ctrl-z
antigen bundle git
antigen bundle last-working-dir
antigen bundle sudo
antigen bundle wd
antigen bundle z
antigen bundle nilsonholger/osx-zsh-completions
# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Vars, aliases
export LC_ALL="en_US.UTF-8"
export BROWSER='firefox'
export EDITOR='vi'
export XDG_CONFIG_HOME=$HOME/.config
export TERM=xterm-256color

if command -v vim > /dev/null; then
    export EDITOR='vim'
fi

if command -v nvim > /dev/null; then
    export EDITOR='nvim'

    neovim_autocd() {
        [[ $NVIM_LISTEN_ADDRESS ]] && ~/bin/neovim-autocd.py
    }
    chpwd_functions+=( neovim_autocd )
fi

remake() {
    make clean || return $?
    if [[ $# == 0 ]]; then
        make
    else
        make $@
    fi
}

weather() {
        curl -4 "http://wttr.in/$1"
}

if command -v bpython > /dev/null; then
    python() {
        if [[ $# == 0 ]]; then
            bpython
        else
            command python $@
        fi
    }
fi

# needed by the wd plugin
wd() {
  . ~/bin/wd/wd.sh
}

export PAGER=/usr/local/bin/vimpager
alias less=$PAGER
alias zless=$PAGER

# Nvim host control
export PATH="$HOME/bin/:$PATH"
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
