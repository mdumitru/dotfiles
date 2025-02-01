# Plugin configurations
#
# All plugins here are sorted alphabetically (for lack of a better order), case
# insensitive ('Ab' comes before 'ac' but after 'aa'). Case-sorting should
# occur only as a secondary criteria ('nAme' comes before 'name').
# All 'oh-my-zsh' plugins come before other plugins.
#
# The description provided above the plugin is (usually, except for 'oh-my-zsh'
# pugins) the short description from github and it should hopefully indicate
# the usefulness of a plugin.


# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Use Ctrl-Z to switch back to background task.
zcomet load "mdumitru/fancy-ctrl-z"

# Useful git aliases and functions.
zcomet load "mdumitru/git-aliases"

# Keeps track of the last used wd and jumps into it for new shells.
zcomet load "mdumitru/last-working-dir"

# Jump to custom directories in zsh
zcomet trigger wd "mfaerevaag/wd"

# jump around
zcomet trigger z "rupa/z"

# zsh anything.el-like widget.
zcomet load "zsh-users/zaw"

# In older zsh versions, this seems incompatible with the syntax highlighting
# plugin.
if is52; then
    # Fish-like autosuggestions for zsh
    zcomet load "zsh-users/zsh-autosuggestions"
fi

# Additional completion definitions for Zsh.
zcomet load "zsh-users/zsh-completions"

# ZSH port of the FISH shell's history search
zcomet load "zsh-users/zsh-history-substring-search"

# Fish shell like syntax highlighting for Zsh.
zcomet load "zsh-users/zsh-syntax-highlighting"


# Source 'local_plugins' file (if any).
if [[ -r "$HOME/.zsh/local_plugins.zsh" ]]; then
    source "$HOME/.zsh/local_plugins.zsh"
fi


zcomet compinit


# Load all plugin settings.
function { # anonymous function used for scoping
    setopt local_options nullglob
    local settings="$HOME/.zsh/plugins.config/"
    local fpath
    for fpath in "$settings"/*.zsh; do
        source "$fpath"
    done
}
