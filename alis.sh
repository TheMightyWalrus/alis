#!/bin/bash

args=("$@")


installDir='/mnt'
rootPart=''
homePart=''
bootPart=''
kbLayout=''

for (( i=0 ; i<$# ; i++ ))
do
	case "${args[i]}" in
		"-i" | "--install")
			((i++))
			$installDir=${args[i]}
			;;
		"-r" | "--root")
			((i++))
			$rootPart=${args[i]}
			;;
		"-h" | "--home")
			((i++))
			$homePart=${args[i]}
			;;
		"-b" | "--boot")
			((i++))
			$bootPart=${args[i]}
			;;
		"-k" | "--kblayout")
			((i++))
			$kbLayout=${args[i]}
			;;
		
	esac

	if [ -z "$rootPart" ]; then exit(1); fi
	if [ -z "$homePart" ]; then $homePart=$rootPart; fi
	if [ -z "$bootPart" ]; then $bootPart=$rootPart; fi

	#install base package

	echo "Installing packages base and base-devel to ${installDir}"
	pacstrap ${installDir} base base-devel


done