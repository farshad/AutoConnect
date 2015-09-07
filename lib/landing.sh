#!/bin/bash

home(){
	clear

	echo "   _         _          ___                            _   "
	echo "  /_\  _   _| |_ ___   / __\___  _ __  _ __   ___  ___| |_ "
	echo " //_\\\| | | | __/ _ \ / /  / _ \| '_ \| '_ \ / _ \/ __| __|"
	echo "/  _  \ |_| | || (_) / /__| (_) | | | | | | |  __/ (__| |_ "
	echo "\_/ \_/\__,_|\__\___/\____/\___/|_| |_|_| |_|\___|\___|\__|"

	echo ""

	echo "1. Mount"
	echo "2. UnMount"
	echo "3. SSH"
	echo "4. Manage"
	echo ""
	echo -n ":> "
	read type
	   case $type in
	       1 ) try_sshfs
	           ;;
	       2 ) try_fusermount
	           ;;
	       3 ) try_ssh
	           ;;
           4 ) manage
           ;;
	       * ) clear && echo "Type is not defined." && exit 0
	   esac
	sleep 1s
	clear

}
