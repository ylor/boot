#!/bin/sh -e
# https://github.com/darrylabbate/dotfiles

touch "$HOME"/.hushlogin
mkdir -p "$HOME/Developer"

# hostname
if read -t 10 -p "Change hostname '$HOSTNAME'? (y/n): " response && [[ $response == [yY] ]]; then
	read -p ": " name
	if [ -n "$name" ]; then
		sudo scutil --set ComputerName "$name"
		sudo scutil --set HostName "$name"
		sudo scutil --set LocalHostName "$name"
	fi
fi

# dock
if read -t 10 -p "Clear Dock? (y/n): " response && [[ $response == [yY] ]]; then
	## clear
	defaults delete "com.apple.dock" "persistent-apps"
	defaults delete "com.apple.dock" "persistent-others"

	# add folders
	for folder in "/Applications" "${HOME}/Downloads"; do
		# key:
		## <arrangement>
		###   1 -> Name
		###   3 -> Date Modified
		###   2 -> Date Added
		###   4 -> Date Created
		###   5 -> Kind
		# <displayas>
		###   0 -> Stack
		###   1 -> Folder
		## <showas>
		###   0 -> Automatic
		###   1 -> Fan
		###   2 -> Grid
		###   3 -> List
		defaults write com.apple.dock persistent-others -array-add "<dict>
            <key>tile-data</key>
            <dict>
                <key>arrangement</key>
                <integer>1</integer>
                <key>displayas</key>
                <integer>1</integer>
                <key>file-data</key>
                <dict>
                    <key>_CFURLString</key>
                    <string>file://${folder}/</string>
                    <key>_CFURLStringType</key>
                    <integer>15</integer>
                </dict>
                <key>file-type</key>
                <integer>3</integer>
                <key>showas</key>
                <integer>0</integer>
            </dict>
            <key>tile-type</key>
            <string>directory-tile</string>
        </dict>"
	done && killall Dock
fi

# filevault
if $(fdesetup status | grep -q "Off.") && read -t 10 -p "Encrypt disk? (y/n): " response && [[ $response == [yY] ]]; then
	sudo fdesetup enable -user "$USER"
fi

# homebrew
if ! [ -x "$(command -v brew)" ]; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"

	brew install bat fish gum mise tldr zoxide                                                # fd fzf yazi
	brew install --cask 1password appcleaner betterdisplay ghostty hyperkey linearmouse maccy #alt-tab utm visual-studio-code helix zed jordanbaird-ice
	fish
fi
