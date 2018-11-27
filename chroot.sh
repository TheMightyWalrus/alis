#!/bin/bash

zoneInfoPath = "/usr/share/zoneinfo/$timezone"
if [ -f $zoneInfoPath ]; 
then 
	ln -s $zoneInfoPath "/etc/localtime"
else
	echo "ERROR: COULD NOT SET TIMEZONE OF FORM $timezone. YOU HAVE TO CHECK MANUALLY"
fi

hwclock --systohc


