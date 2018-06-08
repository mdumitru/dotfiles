# Source ~/.profile if it exists.
if [[ -r "$HOME/.profile" ]]; then
    emulate sh -c 'source "$HOME/.profile"'
fi
