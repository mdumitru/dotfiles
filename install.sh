#!/bin/sh

show_usage() {
	cat <<- __EOF__
	Running this script with no arguments will install config files for zsh,
	vim, nvim and gdb.

	Pass individual arguments to fine-tune the installation.
	Arguments are of the form "install_XXX".

	Example:
	    $0 install_zsh install_gdb
	__EOF__
}

install_zsh() {
	set -x

	rm -rf ~/.zsh
	ln -fs `realpath ./.zsh` ~
	ln -fs `realpath ./.zshrc` ~

	zsh -c "source ~/.zshrc"

	set +x
}

nvim_python() {
	set -x

	if command -v pip2 &> /dev/null; then
		pip2 install --user -U neovim
	fi

	if command -v pip3 &> /dev/null; then
		pip3 install --user -U neovim
	fi

	if command -v pip &> /dev/null; then
		pip install --user -U neovim
	fi

	set +x
}

install_vim() {
	set -x

	rm -rf ~/.vim
	ln -fs `realpath ./.vim` ~
	ln -fs `realpath ./.vimrc` ~
	ln -fs `realpath ./.gvimrc` ~

	if command -v nvim &> /dev/null; then
		mkdir -p ~/bin
		rm -rf ~/bin/nvim
		for file in `ls ./bin`; do
			ln -fs `realpath ./bin/$file` ~/bin/
		done

		mkdir -p ~/.config/nvim
		ln -fs ~/.vimrc ~/.config/nvim/init.vim

		nvim_python
	fi

	set +x
}

install_pgdb() {
	set -x

	mkdir -p ~/gits
	ln -fs `realpath ./gits/peda` ~/gits &> /dev/null
	ln -fs `realpath ./.gdbinit` ~

	set +x
}

main() {
	install_zsh
	install_vim
	install_pgdb
}

if [[ $# == 0 ]]; then
	main
elif [[ $1 == --help || $1 == -h ]]; then
	show_usage
else
	for arg in $@; do
		"$arg"
	done
fi

