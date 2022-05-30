#!/bin/bash

if [ "$1" == "" ] 
then 
	echo "No ip addr"
	echo "Syntax: ./ipsweep.sh 192.168.2"
else
	for ip in `seq 1 254`; do
	ping -c 1 -w 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
	done; wait
fi
