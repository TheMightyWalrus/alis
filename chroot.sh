#!/bin/bash

keymap=$1
locale=$2
hostname=$3
timezone=$4
lang=$5

zoneInfoPath="/usr/share/zoneinfo/$timezone"
if [ -f $zoneInfoPath ]; 
then 
	ln -s $zoneInfoPath "/etc/localtime"
else
	echo "ERROR: COULD NOT SET TIMEZONE OF FORM $timezone. YOU HAVE TO CHECK MANUALLY"
fi

hwclock --systohc

if [ -z $locale ]; 
then 
	echo "ERROR: NO LOCALES SET. YOU HAVE TO GENERATE LOCALES MANUALLY"
else
	echo "" > /etc/locale.gen
	for entry in $locale
	do
		echo entry >> /etc/locale.gen	
	done
	locale-gen
fi

echo $hostname > /etc/hostname
cat /etc/hostname

echo "LANG=$lang" > /etc/locale.conf
cat /etc/locale.conf

echo "KEYMAP=$keymap" > /etc/vconsole.conf
cat /etc/vconsole.conf

echo "127.0.0.1	localhost" > /etc/hosts
echo "::1	localhost" >> /etc/hosts
cat /etc/hosts

echo "generation initramfs"
mkinitcpio -p linux

exit
