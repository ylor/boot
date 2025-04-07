#!/bin/sh -e
# Usage: sh -c "$(curl -fsSL boot.roly.sh)"

REPO="https://github.com/ylor/boot"
DEST="/var/tmp/boot"

BOLD='\033[1m'
UNDERLINE='\033[4m'
RED='\033[31m'
GREEN='\033[32m'
RESET='\033[0m'

[ -d $DEST ] && rm -rf "$DEST"

if ! [ -x "$(command -v git)" ]; then
	git clone --quiet --recursive "$REPO.git" "$DEST"
else
	if [ -x "$(command -v curl)" ]; then # oooookay let's curl the tar
	    mkdir -p "$DEST"
		curl --fail --show-error --location "$REPO/archive/master.tar.gz" | tar --extract --strip-components=1 --directory "$DEST"
	fi
fi

if [ -d "$DEST" ]; then
	echo "${GREEN}✓ SUCCESS:${RESET} initializing..."
	cd "$DEST" && sh init.sh
else
	echo "${RED}✗ ERROR:${RESET} payload download or extraction failed."
	exit 1
fi

rm -rf "$DEST"
