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
	payload="$HOME/.dotfiles"
	git clone --quiet "https://github.com/ylor/dotfiles" "$payload" >/dev/null
	sh "$payload/link.sh" >/dev/null
fi
