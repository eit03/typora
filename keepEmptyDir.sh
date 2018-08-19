#! /bin/sh

###create .ingore dummy file for copying to empty folder
touch .gitingore

###use find the files and folders list 
for i in `find` ; do
	if [ -e $i ] ; then
		if [ ! "`ls -A $i`" ] ; then
			echo $i is empty folder
			cp  .gitingore $i
		fi
	fi
done
