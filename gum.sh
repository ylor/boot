#!/bin/sh -e

if gum confirm "Change hostname? (Current: '$HOSTNAME')"; then
	gum_hostname=$(gum input --placeholder "$HOSTNAME")
	if [ -z "$gum_hostname" ]; then
		echo "srs?"
	else
		echo sudo scutil --set ComputerName "$gum_hostname"
		echo sudo scutil --set HostName "$gum_hostname"
		echo sudo scutil --set LocalHostName "$gum_hostname"
	fi
fi

if fdesetup status | grep -q "Off." && gum confirm "Enable FileVault?"; then
	sudo fdesetup enable -user "$USER"
fi
