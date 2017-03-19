# Source 'before' file (if any).
if test -f "$HOME/.profile.before" -a -r "$HOME/.profile.before"; then
    . "$HOME/.profile.before"
fi

# Add ~/bin/ to path.
PATH="$HOME/bin/:$PATH"
export PATH

# XDG user directories.
# These should not be necessary.
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME

# XDG system directories.
XDG_DATA_DIRS=/usr/local/share:/usr/share
XDG_CONFIG_DIRS=/etc/xdg
export XDG_DATA_DIRS XDG_CONFIG_DIRS

# Source 'after' file (if any).
if test -f "$HOME/.profile.after" -a -r "$HOME/.profile.after"; then
    . "$HOME/.profile.after"
fi
