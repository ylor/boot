#!/bin/sh -e

case $(uname) in
'Darwin')
	sh init.macos.sh
	sh init.macos.defaults.sh
	;;
*)
	echo "Unknown operating system. Aborting..."
	;;
esac

git clone "https://github.com/ylor/dotfiles" "$HOME/.dotfiles"
source "$HOME/.dotfiles/link.sh"