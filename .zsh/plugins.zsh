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

# Needed by oh-my-zsh plugins.
export ZSH="$ZPLUG_HOME/repos/robbyrussell/oh-my-zsh"


# Useful, short aliases for common commands.
zplug "plugins/common-aliases", from:oh-my-zsh

# Use Ctrl-Z to switch back to background task.
zplug "plugins/fancy-ctrl-z", from:oh-my-zsh

# Useful git aliases and functions.
zplug "plugins/git", from:oh-my-zsh

# Keeps track of the last used wd and jumps into it for new shells.
zplug "plugins/last-working-dir", from:oh-my-zsh

# lets you jump to custom directories in zsh, without using cd.
zplug "plugins/wd", from:oh-my-zsh

# jump around
zplug "plugins/z", from:oh-my-zsh

# ZSH completions for selected OS X commands.
zplug "nilsonholger/osx-zsh-completions", if:"[[ $OSTYPE == *darwin* ]]"

# A next-generation plugin manager for zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Fish-like autosuggestions for zsh
#zplug "zsh-users/zsh-autosuggestions"

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
