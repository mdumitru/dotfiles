# Source 'before' file if any.
if [[ -r "$HOME/.zshrc.before" ]]; then
    source "$HOME/.zshrc.before"
fi

# aliases
if [[ -r "$HOME/.zsh_aliases" ]]; then
    source "$HOME/.zsh_aliases"
fi

# check for version/system
# check for versions (compatibility reasons)
is4(){
    [[ $ZSH_VERSION == <4->* ]] && return 0
    return 1
}

is433(){
    [[ $ZSH_VERSION == 4.3.<3->* || $ZSH_VERSION == 4.<4->* \
                                 || $ZSH_VERSION == <5->* ]] && return 0
    return 1
}

is437(){
    [[ $ZSH_VERSION == 4.3.<7->* || $ZSH_VERSION == 4.<4->* \
                                 || $ZSH_VERSION == <5->* ]] && return 0
    return 1
}

is52(){
    [[ $ZSH_VERSION == 5.<2->* || $ZSH_VERSION == <6->* ]] && return 0
    return 1
}

# set some important options (as early as possible)

# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt append_history

# import new commands from the history file also in other zsh-session
is4 && setopt share_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
is4 && setopt histignorealldups

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# report the status of backgrounds jobs immediately
setopt notify

# the behavior of "multios" is counterintuitive
# (e.g. for "echo hi 2>&1 1>/dev/null | cat")
setopt nomultios

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# Invert the meaning of '-' and '+' when accessing directories in the stack.
setopt pushd_minus

# Do not print the directory stack after pushd or popd.
setopt pushd_silent

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

# use zsh style word splitting
setopt noshwordsplit

# don't error out when unset parameters are used
setopt unset

# GRML upstream
if [[ -r "$HOME/.zsh/grml-arch.zsh" ]]; then
    source "$HOME/.zsh/grml-arch.zsh"
fi

# Load all plugins.
if [[ -r "$HOME/.zsh/plugins.zsh" ]]; then
    source "$HOME/.zsh/plugins.zsh"
fi

source <(fzf --zsh)

# Automatically change directories in the host neovim when cd-ing.
if typeset -f nvim_cd > /dev/null; then
    autoload -U add-zsh-hook
    add-zsh-hook chpwd nvim_cd
fi

# Prevent conda from automatically activating.
export CONDA_AUTO_ACTIVATE_BASE=false

# Source 'after' file if any.
if [[ -r "$HOME/.zshrc.after" ]]; then
    source "$HOME/.zshrc.after"
fi
