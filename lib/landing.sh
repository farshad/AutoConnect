#!/bin/bash

home(){
	clear

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
