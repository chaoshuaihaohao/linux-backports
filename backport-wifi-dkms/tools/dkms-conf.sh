#!/bin/bash
# This file is used to generate dkms.conf file conf path.

Usage()
{
	echo dkms-conf.sh tmp
	echo   tmp is the file generated by "find . -name *.ko > tmp"
}

if [ -z $1 ];then
	Usage
	exit;
fi

#./drivers/staging/r8188eu/r8188eu.ko
COUNT=0
for KO in `sed 's:\./::g' $1`
do
	BUILT_MODULE_NAME=$(echo $KO | awk -F '[/.]' '{print $(NF-1)}')
	echo BUILT_MODULE_NAME[$COUNT]='"'$BUILT_MODULE_NAME'"'
	DEST_MODULE_NAME=$BUILT_MODULE_NAME
	echo DEST_MODULE_NAME[$COUNT]='"'$DEST_MODULE_NAME'"'
	BUILT_MODULE_LOCATION=$(echo $KO | awk -F "/$BUILT_MODULE_NAME.ko" '{print $1}')
	echo BUILT_MODULE_LOCATION[$COUNT]='"'$BUILT_MODULE_LOCATION'"'
	DEST_MODULE_LOCATION="/updates/$BUILT_MODULE_LOCATION"	
	echo DEST_MODULE_LOCATION[$COUNT]='"'$DEST_MODULE_LOCATION'"'
	COUNT=$(($COUNT+1))
done
