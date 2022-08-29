#!/bin/bash
# chmod +x this script, then run it
# Needs work, i know, its basic
########################################################################
SERVER_INSTALL_DIR=/home/Aftertaste/LOServer # Change this to your install dir
APP_ID=920720 # Update this if the ID changes, or if you find season 4 id to use instead
###################DO NOT CHANGE ANYTHING BELOW THIS LINE!!!############
SCVERSION=$(apt-cache policy steamcmd | grep Installed)
BIT=x86_86
if [[ "$SCVERSION" = *"(none)"* ]];
	then
		BIT=$(uname -m)
		if [[ "$BIT" = *"64"* ]];
		then
			echo "Setting up for 64 bit SteamCmd"
				sudo add-apt-repository multiverse && sudo apt install software-properties-common -y && sudo dpkg --add-architecture i386 && sudo apt update && sudo apt install lib32gcc-s1 steamcmd -y
		else
			echo "Setting up for 32 bit SteamCmd"
			sudo apt install steamcmd -y
		fi
fi
steamcmd +force_install_dir $SERVER_INSTALL_DIR +login anonymous +app_update $APP_ID validate +exit
echo "$APP_ID" > $SERVER_INSTALL_DIR/Mist/Binaries/Linux/steam_appid.txt
