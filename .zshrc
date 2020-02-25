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

# Source 'after' file if any.
if [[ -r "$HOME/.zshrc.after" ]]; then
    source "$HOME/.zshrc.after"
fi
