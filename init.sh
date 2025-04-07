#!/bin/sh -e

case $(uname) in
'Darwin')
	sh macos/init.sh
	sh macos/defaults.sh
	;;
*)
	echo "Unknown operating system. Aborting..."
	;;
esac

if [ -x $(command -v git) ]; then
	git clone "https://github.com/ylor/dotfiles" "$HOME/.dotfiles"
	sh "$HOME/.dotfiles/link.sh"
fi
