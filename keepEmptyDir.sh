#! /bin/sh

touch .gitignore
for i in `find` ; do
	if [ -e $i ] ; then
		if [ ! "`ls -A $i`" ] ; then
			echo $i is empty folder
			cp  .gitignore $i
		fi
	fi
done
