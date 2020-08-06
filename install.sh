#!/bin/sh
# Dotfiles install script.
#
# The purpose of this script is to make sure all config files are where they
# need to be, all plugins are installed and, in general, complete other forms of
# setup.
#
# It should adhere to the following principles:
#   - written in pure shell for maximum portability
#   - modularized: easy to add components; easy to select components at runtime
#   - no harmful effects (i.e. should be able to backup/restore)


OPTIND=1
BACKUPDIR="$HOME/dotfiles_backups/$(date '+%y%m%d_%H%M%S')"
BACKUP=1
RESTORE=0
DELETE_BACKUP_AFTER_RESTORE=0
INSTALL_LIST=""
SH_INSTALLED=0
VIM_INSTALLED=0
VIM_PLUGINS_INSTALLED=0

show_help() {
    cat << __EOF__
Dotfiles install script.

This should be invoked from its folder (the dotfiles folder). If this is the
same as the HOME folder, not much is needed to be done.

Arguments:
    -h/-?
        display this help message

    -i <component>
        install the target component. Available components are:
            alacritty
            bash
            git
            i3
            nvim
            pgdb
            rofi
            search
            shell
            vim
            xvim
            ycm
            zsh

        If no "-i" option is provided, ALL components are installed.

    -n
do not perform backup of previous dotfiles; the backup is done by
        default

    -r
        restore backupped dotfiles from the backup directory; this should not be
        used together with "-i" options

    -d
        delete the backup after restoring; by default, the backup is left intact

    -b <backup-dir>
        set the backup directory; default is: "$BACKUPDIR"

__EOF__
}

do_backup() {
    trap "echo Backup failed! Aborting ..." EXIT
    set -e

    for item; do
        if test -e "$HOME/$item"; then
            item_dir=$(dirname "$item")
            item_basename=$(basename "$item")
            dst_dir="$BACKUPDIR/$item_dir"
            mkdir -p "$dst_dir"

            mv "$HOME/$item" "$dst_dir/$item_basename"
        fi
    done

    set +e
    trap "" EXIT
}

restore_backup() {
    trap "echo Backup failed! Aborting ..." EXIT
    set -e

    cd "$BACKUPDIR"
    find . -type f | while IFS= read -r item
    do
        homefile="$HOME/$item"

        echo "Restoring \"$item\" ..."
        rm -rf "$homefile"
        dir=$(dirname "$item")
        mkdir -p "$HOME/$dir"
        if test $DELETE_BACKUP_AFTER_RESTORE -eq 1; then
            mv "$item" "$HOME"
        else
            cp -R "$item" "$HOME"
        fi
    done

    if test $DELETE_BACKUP_AFTER_RESTORE -eq 1; then
        echo "Removing backup directory \"$BACKUPDIR\" ..."
        rm -rf "$BACKUPDIR"
    fi
    cd -

    set +e
    trap "" EXIT
}

install_helper() {
    if test $BACKUP -eq 1; then
        do_backup "$@"
    fi

    for item; do
        dir=$(dirname "$item")
        dst_dir="$HOME/$dir"
        mkdir -p "$dst_dir"

        echo "Copying \"$item\" ..."
        rm -rf "${dst_dir:?}/$item"
        ln -s "$(realpath "$item")" "$dst_dir"
    done
}

install_shell() {
    echo "Installing shell files ..."
    install_helper ".profile" ".aliases"
    SH_INSTALLED=1
}

install_zsh() {
    if test $SH_INSTALLED -eq 0; then
        install_shell
    fi

    if ! command -v zsh > /dev/null; then
        echo "\"zsh\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing zsh files ..."
    install_helper ".zprofile" ".zshrc" ".zsh_aliases" ".zsh"

    install_zsh_plugins
}

install_zsh_plugins() {
    if ! command -v zsh > /dev/null; then
        echo "\"zsh\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing zsh plugins ..."
    zsh -c "source $HOME/.zshrc; zplug install"
}

install_bash() {
    if test $SH_INSTALLED -eq 0; then
        install_shell
    fi

    if ! command -v bash > /dev/null; then
        echo "\"bash\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing bash files ..."
    install_helper ".bash_profile" ".bashrc" ".bash_aliases"
}

install_vim() {
    echo "Installing vim files ..."
    install_helper ".vimrc" ".gvimrc" ".vim"

    # Maybe neovim is present, but not vim. We still need the above files, so we
    # check for vim's existance only after.
    if ! command -v vim > /dev/null; then
        echo "\"vim\" not found! Nothing to do here ..." >&2
        return 0
    fi

    install_vim_plugins
    VIM_INSTALLED=1
}

install_vim_plugins() {
    if ! command -v vim > /dev/null; then
        echo "\"vim\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing vim plugins ..."
    vim "+PlugInstall | qa!"
    VIM_PLUGINS_INSTALLED=1
}

install_nvim() {
    if test $VIM_INSTALLED -eq 0; then
        install_vim
    fi

    if ! command -v nvim > /dev/null; then
        echo "\"nvim\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing nvim files ..."
    install_helper ".config/nvim" "bin/nvim-host-cmd" "bin/nvim-host-editor" \
        ".local/share/nvim"
    install_nvim_plugins
    install_nvim_python
}

install_nvim_plugins() {
    if ! command -v nvim > /dev/null; then
        echo "\"nvim\" not found! Nothing to do here ..." >&2
        return 0
    fi

    if test $VIM_PLUGINS_INSTALLED -eq 1; then
        return 0
    fi

    echo "Installing nvim plugins ..."
    nvim "+PlugInstall | qa!"
}

install_nvim_python() {
    echo "Installing neovim python package ..."

    # Ensure this is installed in all possible pips.
    if command -v pip2 > /dev/null; then
        pip2 install --user --upgrade --no-warn-conflicts pynvim
    fi

    if command -v pip3 > /dev/null; then
        pip3 install --user --upgrade --no-warn-conflicts pynvim
    fi

    if command -v pip > /dev/null; then
        pip install --user --upgrade --no-warn-conflicts pynvim
    fi
}

install_xvim() {
    if test $VIM_INSTALLED -eq 0; then
        install_vim
    fi

    echo "Installing xvim files ..."
    install_helper ".xvimrc"
}

install_pgdb() {
    echo "Installing peda gdb ..."
    install_helper "gits/peda" ".gdbinit"
}

install_ycm() {
    echo "Installing ycm files ..."
    install_helper ".ycm_extra_conf.py"
}

install_search() {
    echo "Installing search files ..."
    install_helper ".ignore"
}

install_git() {
    echo "Installing git files ..."
    install_helper ".gitconfig" "bin/diff-so-fancy"
}

install_alacritty() {
    if ! command -v alacritty > /dev/null; then
        echo "\"alacritty\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing alacritty files ..."
    install_helper ".config/alacritty"
}

install_i3() {
    if ! command -v i3 > /dev/null; then
        echo "\"i3\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing i3 files ..."
    install_helper ".config/i3"
}

install_rofi() {
    if ! command -v rofi > /dev/null; then
        echo "\"rofi\" not found! Nothing to do here ..." >&2
        return 0
    fi

    echo "Installing rofi files ..."
    install_helper ".config/rofi"
}

setup() {
    git submodule init
    git submodule update
}

install_in_home() {
    install_zsh_plugins
    install_vim_plugins
    install_nvim_plugins
}

install_all() {
    install_zsh
    install_bash
    install_nvim
    install_pgdb
    install_ycm
    install_search
    install_git
    install_alacritty
    install_i3
    install_rofi
}

install() {
    if test -z "$@"; then
        install_all
    else
        for item; do
            # shellcheck disable=SC2086
            install_$item
        done
    fi
}

# Ensure we can use "realpath".
if ! command -v realpath > /dev/null; then
    # shellcheck source=/dev/null
    . "$(pwd)/sh-realpath/realpath.sh"
fi

setup
if test "$(pwd)" = "$HOME"; then
    install_in_home
    exit 0
fi

while getopts "h?bdnri:" opt; do
    case "$opt" in
        h|\?)
            show_help
            exit 0
            ;;
        b)
            BACKUPDIR="$OPTARG"
            ;;
        d)
            DELETE_BACKUP_AFTER_RESTORE=1
            ;;
        n)
            BACKUP=0
            ;;
        r)
            RESTORE=1
            ;;
        i)
            INSTALL_LIST="$OPTARG $INSTALL_LIST"
            ;;
    esac
done

if test $RESTORE -eq 1; then
    restore_backup
    exit 0
fi

if test $BACKUP -eq 1; then
    mkdir -p "$BACKUPDIR"
    if test "$(find "$BACKUPDIR" | wc -l)" -ne 1; then
        echo "Backup directory not empty! Aborting ..." >&2
        exit 1
    fi
fi

install "$INSTALL_LIST"
