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
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Make suggestions visible on solarized background.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'


# Vars, aliases
export LC_ALL="en_US.UTF-8"
export BROWSER='firefox'
export XDG_CONFIG_HOME=$HOME/.config
export PATH="$HOME/bin/:$PATH"


# Interaction with neovim when running from its guest terminal.
if check_com -c nvim; then
    # The editor is set as vi/vim by grml-arch.
    export EDITOR='nvim'
    export VIMPAGER_VIM='nvim'

    if [[ $NVIM_LISTEN_ADDRESS ]] && check_com -c nvim-host-cmd; then
        # Change nvim host's cwd when cd-ing from within a terminal.
        neovim_autocd() {
            nvim-host-cmd "execute \"tcd\" fnameescape(\"`pwd`\")"
        }
        chpwd_functions+=( neovim_autocd )

        alias v=nvim-host-cmd
        alias e='nvim-host-cmd edit'
        alias tabe='nvim-host-cmd tabedit'
        alias sp='nvim-host-cmd split'
        alias vsp='nvim-host-cmd vsplit'
        alias bosp='nvim-host-cmd botright split'
    fi
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

export PAGER=vimpager
alias vp=vimpager
alias vc=vimcat
alias -g V='| vimpager'
