#!/bin/bash
source ./lib/core.sh
source ./lib/landing.sh 

while getopts "h|m" opt; do
  case $opt in
  	h)
	  echo "Usage:          autoconnect [operand number] [host number]"
	  echo "operand number:"
	  echo "                1)  Mount"
	  echo "                11) Mount All Hosts"
	  echo "                2)  UnMount"
	  echo "                22) UnMount All Hosts"
	  echo "                3)  SSH"
	  echo ""
      echo "-h              help"
      echo "-m              manage hosts"
      echo ""
      exit 1;;
    m)
      home
      ;;
    \?) 
		echo "Invalid option: -"$OPTARG"" >&2
        exit 1;;
  esac
done

if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "No argument supplied"
    exit 1
else
	home $1 $2
fi 

