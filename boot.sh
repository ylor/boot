#!/bin/sh -e
# Usage: sh -c "$(curl -fsSL boot.roly.sh)"

repo="https://github.com/ylor/boot"
dest="$HOME/.local/share/boot"

bold='\033[1m'
underline='\033[4m'
red='\033[31m'
green='\033[32m'
reset='\033[0m'

[ -d $dest ] && rm -rf "$dest" && mkdir -p "$dest"

echo "cloning..."

if [ -x $(command -v git) ]; then
	git clone --quiet --recursive "$repo.git" "$dest" >/dev/null
else
	curl --fail --show-error --location "$repo/archive/master.tar.gz" | tar --extract --strip-components=1 --directory "$dest"
fi

echo "initializing..."
if [ -d "$dest" ]; then
	cd "$dest" && sh init.sh
	echo "${green}✓"
else
	echo "${red}✗ ERROR"
	exit 1
fi
