#!/bin/bash

args=("$@")

echo "Setting default"

installDir='/mnt'
rootPart=''
homePart=''
bootPart=''
kbLayout=''

echo "Parsing args"
for (( i=0 ; i<$# ; i++ ))
do
	case "${args[i]}" in
		"-i" | "--install")
			((i++))
			installDir=${args[i]}
			;;
		"-r" | "--root")
			((i++))
			rootPart=${args[i]}
			;;
		"-h" | "--home")
			((i++))
			homePart=${args[i]}
			;;
		"-b" | "--boot")
			((i++))
			bootPart=${args[i]}
			;;
		"-k" | "--kblayout")
			((i++))
			kbLayout=${args[i]}
			;;
		
	esac
done


echo "Checking if Partitions differ from default"

if [ -z $rootPart ]; then exit 1; fi

#install base package

echo "mounting root $rootPart on $installDir"
mount $rootPart $installDir

if [ -n $homePart ];
then
	echo "mounting home $home on $installDir/home"
	mkdir $installDir/home
	mount $homePart $installDir/home
fi


if [ -n $bootPart ];
then
	echo "mounting boot $boot on $installDir/boot"
	mkdir $installDir/boot
	mount $bootPart $installDir/boot
fi
	

echo "Installing packages base and base-devel to $installDir"
pacstrap ${installDir} base base-devel && genfstab $installDir >> $installDir/etc/fstab

echo "yay"

