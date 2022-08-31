#!/bin/bash
# chmod +x this script, then run it
# Needs work, i know, its basic
# tested Ubuntu 20.04.4-live 64 bit
# tested Debian 11.3.0-amd64 bit
########################################################################
SERVER_INSTALL_DIR=/home/dcosper/LOServer # Change this to your install dir
APP_ID=920720 # Update this if the ID changes, or if you find season 4 id to use instead
###################DO NOT CHANGE ANYTHING BELOW THIS LINE!!!############

debian64()
{
	sudo sed -i 's/main/main contrib non-free/' /etc/apt/sources.list
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt install steamcmd
}
ubuntu64()
{
	sudo add-apt-repository multiverse && sudo apt install software-properties-common -y && sudo dpkg --add-architecture i386 && sudo apt update && sudo apt install lib32gcc-s1 steamcmd -y
}
steamcmdinstall()
{
	steamcmd +force_install_dir $SERVER_INSTALL_DIR +login anonymous +app_update $APP_ID validate +exit
	echo "$APP_ID" > $SERVER_INSTALL_DIR/Mist/Binaries/Linux/steam_appid.txt
}

SCVERSION=$(apt-cache policy steamcmd | grep Installed)

DISTRO="Unsupported"

SYSTEM="Debian"

BIT="32"

if [[ "$SCVERSION" = *"(none)"* || "$SCVERSION" = "" ]];
	then
		DISTRO=$(uname -a)
	else
		steamcmdinstall
		exit 0
fi

if [[ "$DISTRO" = "Unsupported" ]];
	then
		echo "Unsupported system, install manually."
			exit 0
	else
		if [[ "$DISTRO" = *"Debian"* && "$DISTRO" = *"64"* ]];
			then
				SYSTEM="Debian"
				BIT="64"
				fi
		if [[ "$DISTRO" = *"Ubuntu"* && "$DISTRO" = *"64"* ]];
			then
				SYSTEM="Ubuntu"
				BIT="64"
				fi
fi

# Works do distro specific stuff here

if [[ "$SYSTEM" = "Debian" ]];
	then
	if [[ "$BIT" = "64" ]];
		then
		debian64
	else if [[ "$BIT" = "32" ]];
		then
		echo "32 bit Debian"
		fi
	fi
fi
if [[ "$SYSTEM" = "Ubuntu" ]];
	then
	if [[ "$BIT" = "64" ]];
		then
		ubuntu64
	else if [[ "$BIT" = "32" ]];
		then
		echo "32 bit Ubutu"
		fi
	fi
fi

steamcmdinstall
