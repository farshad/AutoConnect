#!/bin/bash

home(){
	if [ -z "$1" ]
	  then
	  	clear
		echo "   _         _          ___                            _   "
		echo "  /_\  _   _| |_ ___   / __\___  _ __  _ __   ___  ___| |_ "
		echo " //_\\\| | | | __/ _ \ / /  / _ \| '_ \| '_ \ / _ \/ __| __|"
		echo "/  _  \ |_| | || (_) / /__| (_) | | | | | | |  __/ (__| |_ "
		echo "\_/ \_/\__,_|\__\___/\____/\___/|_| |_|_| |_|\___|\___|\__|"

		echo ""

		echo "1.  Mount"
		echo "11. Mount All"

		echo ""

		echo "2.  UnMount"
		echo "22. UnMount All"

		echo ""

		echo "3.  SSH"

		echo ""
		echo "4.  Manage"

		echo ""
		echo -n ":> "
		read type
	else
		type=$1
	fi
   case $type in
	1 ) try_sshfs
		;;
	11 ) try_mount_all
		;;
	2 ) try_fusermount
		;;
	22 ) try_unmount_all
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
