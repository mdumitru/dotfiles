# Source 'before' file if any.
if [[ -r "$HOME/.zshrc.before" ]]; then
    source "$HOME/.zshrc.before"
fi

# aliases
if [[ -r "$HOME/.zsh_aliases" ]]; then
    source "$HOME/.zsh_aliases"
fi

# GRML upstream
if [[ -r "$HOME/.zsh/grml-arch.zsh" ]]; then
    source "$HOME/.zsh/grml-arch.zsh"
fi

# Load all plugins.
if [[ -r "$HOME/.zsh/plugins.zsh" ]]; then
    source "$HOME/.zsh/plugins.zsh"
fi


# Reclaim incremental forward history search.
stty stop undef && stty start undef || true


# Vars, aliases
export PAGER=vimpager

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

if command -v bpython > /dev/null; then
    py() {
        if [[ $# == 0 ]]; then
            bpython
        else
            command python $@
        fi
    }
else
    alias py='python'
fi


# Source 'after' file if any.
if [[ -r "$HOME/.zshrc.after" ]]; then
    source "$HOME/.zshrc.after"
fi
