#!/bin/sh -e

touch "$HOME"/.hushlogin
mkdir -p "$HOME/Developer"

# homebrew
if ! [ -x $(command -v brew) ]; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"

	brew install bat fish gum mise tldr zoxide # fd fzf yazi
	brew install --cask 1password appcleaner betterdisplay ghostty hyperkey linearmouse maccy #alt-tab utm visual-studio-code helix zed jordanbaird-ice
	fish
fi

# dock
if defaults read com.apple.Dock | grep -q "com.apple.launchpad.launcher"; then
    dockutil --remove all \
	--add "/Applications" \
	--add "~/Downloads" >/dev/null
fi
