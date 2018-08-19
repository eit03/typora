#! /bin/sh

###create .ingore dummy file for copying to empty folder
touch .gitignore

###use find the files and folders list 
for i in `find` ; do
	if [ -e $i ] ; then
		if [ ! "`ls -A $i`" ] ; then
			echo $i is empty folder
			cp  .gitignore $i
		fi
	fi
done
