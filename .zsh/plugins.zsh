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


# Attempt to source the plugin manager.
manager_path="$HOME/.zsh/zplug/init.zsh"
if [[ ! -r "$manager_path" ]]; then
    return
fi
source "$manager_path"

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf"

# A command-line fuzzy finder
zplug "junegunn/fzf", \
    hook-build:"./install --bin", \
    use:"shell/*.zsh"

# Use Ctrl-Z to switch back to background task.
zplug "mdumitru/fancy-ctrl-z"

# Useful git aliases and functions.
zplug "mdumitru/git-aliases"

# Keeps track of the last used wd and jumps into it for new shells.
zplug "mdumitru/last-working-dir"

# Jump to custom directories in zsh
zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $HOME/gits/wd/wd.sh }"

# ZSH completions for selected OS X commands.
zplug "nilsonholger/osx-zsh-completions", if:"[[ $OSTYPE == *darwin* ]]"

# jump around
zplug "rupa/z", use:"z.sh"

# A next-generation plugin manager for zsh
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# zsh anything.el-like widget.
zplug "zsh-users/zaw"

# In older zsh versions, this seems incompatible with the syntax highlighting
# plugin.
if is52; then
    # Fish-like autosuggestions for zsh
    zplug "zsh-users/zsh-autosuggestions"
fi

# Additional completion definitions for Zsh.
zplug "zsh-users/zsh-completions"

# ZSH port of the FISH shell's history search
zplug "zsh-users/zsh-history-substring-search", defer:3

# Fish shell like syntax highlighting for Zsh.
zplug "zsh-users/zsh-syntax-highlighting", defer:2


# Source 'local_plugins' file (if any).
# This file should contain only 'zplug' directives.
if [[ -r "$HOME/.zsh/local_plugins.zsh" ]]; then
    source "$HOME/.zsh/local_plugins.zsh"
fi


zplug "load"


# Load all plugin settings.
function { # anonymous function used for scoping
    setopt local_options nullglob
    local settings="$HOME/.zsh/plugins.config/"
    local fpath
    for fpath in "$settings"/*.zsh; do
        source "$fpath"
    done
}
