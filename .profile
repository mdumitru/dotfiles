# Source 'before' file (if any).
if test -f "$HOME/.profile.before" -a -r "$HOME/.profile.before"; then
    . "$HOME/.profile.before"
fi

# Add ~/bin/ to path.
PATH="$HOME/bin/:$PATH"
export PATH

# As env variables are inherited by regular interactive shells, they should be
# set here so only the login shells modify them.
if command -v nvim > /dev/null; then
    if command -v nvim-host-editor > /dev/null; then
        EDITOR=nvim-host-editor
    else
        EDITOR=nvim
    fi

    # Needed for vimpager, harmless in its absence.
    VIMPAGER_VIM=nvim
else
    if command -v vim > /dev/null; then
        EDITOR=vim
    else
        EDITOR=vi
    fi
fi
export EDITOR

VISUAL="$EDITOR"
export VISUAL

if command -v vimpager > /dev/null; then
    PAGER=vimpager
    export PAGER
    export VIMPAGER_VIM
fi

# XDG user directories.
# These should not be necessary.
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME

# XDG system directories.
XDG_DATA_DIRS=/usr/local/share:/usr/share
XDG_CONFIG_DIRS=/etc/xdg
export XDG_DATA_DIRS XDG_CONFIG_DIRS

# Prefer UTF-8 English.
if locale -a | grep -F -q -x "en_US.UTF-8"; then
    LC_ALL="en_US.UTF-8"
    export LC_ALL
fi

# Reclaim incremental forward history search (and get rid of the idiotic stop).
stty stop undef && stty start undef || true


# Source 'after' file (if any).
if test -f "$HOME/.profile.after" -a -r "$HOME/.profile.after"; then
    . "$HOME/.profile.after"
fi
