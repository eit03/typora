***
[TOC]
***

# `1 Installation of git`
```
apt install git
```
# `2 Config of git`
```
git config --global user.name $(userNameString)
git config --global user.email $(userEmailString)
```
# `3 ssh key`
```
ssh-keygen
查看命令可以确定生成位置,找到id_rsa.pub,添加公钥到你的GitHub的ssh中,这样你就有pull权限了.
```

# `4 Clone repository`
```
git clone git@github.com:$(userNameString)/$(repositoryNameString).git
```

# `5 Upload empty directory`
```
#keepEmptyDir.sh
#to add file to empty dir which dir is no dir and file.

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
```

# `6 Pull master`
```
#push.sh
#to pull repository to master

#!/bin/sh

chmod +x keepEmptyDir.sh
./keepEmptyDir.sh

git add .
git commit -m "1"
git push git@github.com:$(userNameString)/$(repositoryNameString).git
```
