# Source 'before' file (if any).
if test -f "$HOME/.profile.before" -a -r "$HOME/.profile.before"; then
    . "$HOME/.profile.before"
fi

# Add ~/bin/ and ~/.local/bin to path.
PATH="$HOME/bin/:$HOME/.local/bin:$PATH"

# Add cabal stuff to path
PATH="$HOME/.cabal/bin/:$PATH"

# Add cargo stuff to path
PATH="$HOME/.cargo/bin/:$PATH"

export PATH

# As env variables are inherited by regular interactive shells, they should be
# set here so only the login shells modify them.
if command -v nvim > /dev/null; then
    EDITOR=nvim-host-editor

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

GTK_IM_MODULE=ibus
XMODIFIERS="@im=ibus"
QT_IM_MODULE=ibus
XIM_PROGRAM="/urs/bin/ibus-daemon -drx"
export GTK_IM_MODULE XMODIFIERS QT_IM_MODULE XIM_PROGRAM

XIM=ibus
XIM_ARGS="-d"
XIM_PROGRAM_SETS_ITSELF_AS_DAEMON=yes
DEPENDS="ibus"
export XIM XIM_ARGS XIM_PROGRAM_SETS_ITSELF_AS_DAEMON DEPENDS

# Prefer UTF-8 English.
if locale -a | grep -F -q -x "en_US.UTF-8"; then
    LC_ALL="en_US.UTF-8"
    export LC_ALL
fi

# Source 'after' file (if any).
if test -f "$HOME/.profile.after" -a -r "$HOME/.profile.after"; then
    . "$HOME/.profile.after"
fi
