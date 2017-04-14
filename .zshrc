# Source 'before' file if any.
if [[ -r "$HOME/.zshrc.before" ]]; then
    source "$HOME/.zshrc.before"
fi

# GRML upstream
if [[ -r "$HOME/.zsh/grml-arch.zsh" ]]; then
    source "$HOME/.zsh/grml-arch.zsh"
fi

# Load all plugins.
if [[ -r "$HOME/.zsh/plugins.zsh" ]]; then
    source "$HOME/.zsh/plugins.zsh"
fi


# Vars, aliases
export BROWSER='firefox'
export PAGER=vimpager
alias ag='ag --path-to-ignore ~/.ignore'
alias vp=vimpager
alias vc=vimcat
alias -g V='| vimpager'


# Interaction with neovim when running from its guest terminal.
if check_com -c nvim; then
    # The editor is set as vi/vim by grml-arch.
    export EDITOR='nvim-host-editor'
    export VISUAL='nvim-host-editor'
    export VIMPAGER_VIM='nvim'

    if [[ -w "$NVIM_LISTEN_ADDRESS" ]] && check_com -c nvim-host-cmd; then
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
        alias bo='nvim-host-cmd botright'
        alias to='nvim-host-cmd topleft'
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


# Source 'after' file if any.
if [[ -r "$HOME/.zshrc.after" ]]; then
    source "$HOME/.zshrc.after"
fi
