#!/bin/bash
source ./lib/config.sh 

#return server alias list
alias_list(){
	id=10000000000
	while [[ " ${alias_array[*]} " != *" ${alias_array[$((id-1))]} "* ]]; do
		if [[ $id != 10000000000 ]]; then
			clear
			echo "Please select correct option!"
		fi
		for i in "${!alias_array[@]}"; do 
			printf "%s. %s\n" $((i+1)) "${alias_array[$i]}"
		done
		echo ""
		printf "%s. %s\n" 0 "Back to home"
		echo -n ":> "
		read id
		if [[ $id == 0 ]]; then
			home
		fi
	done
}

#check server exist
servers_check(){
	clear
	if [ "${#alias_array[@]}" -eq 0 ]; then
		clear && echo "Server not found, please add new server." && sleep 2s && manage;
	fi
}

#add server to config file
add(){
	clear
	if [ ! -f ./lib/config.sh ]; then
		echo "config file no found"
	    touch ./lib/config.sh 
	    echo "Config.sh generated! please don't modify or delete this file"
	fi
	config_file="./lib/config.sh"

	# read server data
	while [ -z "$alias" ]
	do
		echo -n "Enter server alias: "
  		read alias
  		if [[ " ${alias_array[*]} " == *" $alias "* ]]; then 
  			clear && echo "Err: $alias is exists!" && alias=""; 
  		fi
	done
	while [ -z "$ip" ]
	do
		echo -n "Enter server ip: "
  		read ip
	done

	echo -n "Enter port(default 22): "
  	read port
  	#if port null set 22
  	if [ -z "$port" ]; then port=22; fi

	while [ -z "$user" ]
	do
		echo -n "Enter username: "
  		read user
	done
	while [ -z "$pass" ]
	do
		echo -n "Enter password: "
		read -s pass
	done

	# save server info in config file
	echo "alias_array+=($alias)" >> $config_file
	echo "arr[$alias,ip]=$ip" >> $config_file
	echo "arr[$alias,port]=$port" >> $config_file
	echo "arr[$alias,user]=$user" >> $config_file
	echo "arr[$alias,pass]='$pass'" >> $config_file
	echo -e "\n" >> $config_file
	#make directory for mount
	echo ""
	echo "sudo mkdir /mnt/$alias"
	sleep 1s
	sudo mkdir /mnt/$alias
	sleep 1s
	echo "sudo chmod -R 777 /mnt/$alias"
	sleep 1s
	sudo chmod -R 777 /mnt/$alias

	clear
	exit
}

#delete server from config file
delete(){
	servers_check
	echo "Select server to remove: "
	echo ""
	alias_list
	#unmount
	fusermount -u /mnt/"${alias_array[$((id-1))]}"
	clear
	grep -v "${alias_array[$((id-1))]}" ./lib/config.sh > ./lib/.temp.sh && mv -f ./lib/.temp.sh ./lib/config.sh
	if [ -d "/mnt/${alias_array[$((id-1))]}" ]; then
	  sudo rm -rf /mnt/"${alias_array[$((id-1))]}"
	fi
	exit
}

#add or delete
manage(){
	clear

	echo "1. Add"
	echo "2. Delete"
	echo ""
	echo "0. Back to home"
	echo -n ":> "
	read type
	   case $type in
	       1 ) add
	           ;;
	       2 ) delete
	           ;;
           0 ) home
           ;;
	       * ) clear && echo ">>Error: Type is not defined."  && sleep 2s && manage
	   esac
	sleep 1s
	clear
}

#ssh to server
try_ssh(){
	servers_check
	echo "Select server for ssh: "
	echo ""
	alias_list
	user=${arr[${alias_array[$((id-1))]},user]}
	ip=${arr[${alias_array[$((id-1))]},ip]}
	port=${arr[${alias_array[$((id-1))]},port]}
	pass=${arr[${alias_array[$((id-1))]},pass]}

	expect ./lib/ssh.exp "$user" "$ip" "$port" "$pass"
}

#mount server with sshfs
try_sshfs(){
	servers_check

	echo "Select server for mount: "
	echo ""

	alias_list
	point=${alias_array[$((id-1))]}
	user=${arr[${alias_array[$((id-1))]},user]}
	ip=${arr[${alias_array[$((id-1))]},ip]}
	port=${arr[${alias_array[$((id-1))]},port]}
	pass=${arr[${alias_array[$((id-1))]},pass]}
	#unmount if mounted
	fusermount -u /mnt/$point
	clear
	echo "> Please wait..."
	echo "$pass" | sshfs $user@$ip:/ /mnt/$point -p$port -o password_stdin
	clear
}

# Mount all servers with sshfs
try_mount_all(){
	servers_check

	clear
	echo "> Please wait..."

	for i in "${!alias_array[@]}"; do
		point=${alias_array[$i]}
		user=${arr[${alias_array[$i]},user]}
		ip=${arr[${alias_array[$i]},ip]}
		port=${arr[${alias_array[$i]},port]}
		pass=${arr[${alias_array[$i]},pass]}

		#unmount if mounted
		fusermount -u /mnt/$point >/dev/null 2>/dev/null

		echo "$pass" | sshfs $user@$ip:/ /mnt/$point -p$port -o password_stdin
	done

	clear
}

#unmount server
try_fusermount(){
	servers_check
	echo "Select server for unmount: "
	echo ""
	alias_list
	fusermount -u /mnt/${alias_array[$((id-1))]}
}

# Unmount all servers
try_unmount_all(){
	servers_check

	for i in "${!alias_array[@]}"; do
		fusermount -u /mnt/${alias_array[$i]} >/dev/null 2>/dev/null
	done

	clear
}
