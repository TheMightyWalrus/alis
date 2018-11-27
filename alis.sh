#!/bin/bash

args=("$@")

echo "Setting default"

installDir='/mnt'
rootPart=''
homePart=''
bootPart=''
keymap='us'
hostname='ArchLinuxPC'
locale='en_US.UTF-8'
timezone='Europe/Berlin'


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
		"-k" | "--keymap")
			((i++))
			keymap=${args[i]}
			;;
		"-l" | "--locale")
			((i++))
			locale=${args[i]}
			;;
		"-H" | "--hostname")
			((i++))
			hostname=${args[i]}
			;;
		"-t" | "--timezone")
			((i++))
			timezone=${args[i]}
			;;

		
	esac
done


echo "Checking if Partitions differ from default"

if [ -z $rootPart ]; then echo "Unspecified rootPartition. Speficy with -r or --root"; exit 1; fi

#install base package

echo "mounting root $rootPart on $installDir"
mount $rootPart $installDir

if [ ! -z $homePart ];
then
	echo "mounting home $homePart on $installDir/home"
	mkdir $installDir/home
	mount $homePart $installDir/home
fi


if [ ! -z $bootPart ]; #-n give true on a=''??
then
	echo "mounting boot $bootPart on $installDir/boot"
	mkdir $installDir/boot
	mount $bootPart $installDir/boot
fi
	

#echo "Installing packages base $installDir"
#(pacstrap ${installDir} "base" ) && \
#(genfstab $installDir >> $installDir/etc/fstab)

cp $(dirname $0)"/chroot.sh" $installDir
arch-chroot $installDir "/usr/bin/bash" "/chroot.sh" "$keymap" "$locale" "$hostname" "$timezone"

echo "yay"

