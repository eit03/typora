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

# `git command`

## `status`

```
$ git status ---adsl
error: unknown option `-adsl'
usage: git status [<options>] [--] <pathspec>...

    -v, --verbose         be verbose
    -s, --short           show status concisely
    -b, --branch          show branch information
    --show-stash          show stash information
    --ahead-behind        compute full ahead/behind values
    --porcelain[=<version>]
                          machine-readable output
    --long                show status in long format (default)
    -z, --null            terminate entries with NUL
    -u, --untracked-files[=<mode>]
                          show untracked files, optional modes: all,
 											normal, no. (Default: all)
    --ignored[=<mode>]    show ignored files, optional modes: traditional,
					 						matching, no. (Default: traditional)
    --ignore-submodules[=<when>]
                          ignore changes to submodules, optional when: 
  										all,dirty, untracked. (Default: all)
    --column[=<style>]    list untracked files in columns
    --no-renames          do not detect renames
    -M, --find-renames[=<n>]
                          detect renames, optionally set similarity index
    --show-ignored-directory
                          (DEPRECATED: use --ignore=matching instead) Only
 											show directories that match an ignore pattern
 											name.
    --no-lock-index       (DEPRECATED: use `git --no-optional-locks
 											status` instead) Do not lock the index
```

### `git status`
###　`git status -s`

## `diff`

```
git diff --help
```

### `git diff`
What have you changed but not yet staged?

That command compares what is in your working directory with what is in your staging area. The result tells you the changes you’ve made that you haven’t yet staged.
### `git diff --staged`
what have you staged that you are about to commit?

This command compares your staged changes to your last commit.

## `commit`

### `git commit -m`
### `git commit -a`

## `remote`

### `git remote`

To see which remote servers you have configured, you can run the git remote command. It lists the shortnames of each remote handle you’ve specified.

the shortname of origin :  that is the default name Git gives to the server you cloned from.

```
$ git remote
origin
```

### `git remote -v`

You can also specify -v, which shows you the URLs that Git has stored for the shortname to be used when reading and writing to that remote:

```
$ git remote -v
origin  https://github.com/eit03/QtDocFmt.git (fetch)
origin  https://github.com/eit03/QtDocFmt.git (push)
```

## `tag`

```
$ git tag ---list
error: unknown option `-list'
usage: git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]
   or: git tag -d <tagname>...
   or: git tag -l [-n[<num>]] [--contains <commit>] [--no-contains 
       <commit>] [--points-at <object>] [--format=<format>] [--[no-]merged
       [<commit>]] [<pattern>...]
   or: git tag -v [--format=<format>] <tagname>...

    -l, --list            list tag names
    -n[<n>]               print <n> lines of each tag message
    -d, --delete          delete tags
    -v, --verify          verify tags

Tag creation options
    -a, --annotate        annotated tag, needs a message
    -m, --message <message>
                          tag message
    -F, --file <file>     read message from file
    -e, --edit            force edit of tag message
    -s, --sign            annotated and GPG-signed tag
    --cleanup <mode>      how to strip spaces and #comments from message
    -u, --local-user <key-id>
                          use another key to sign the tag
    -f, --force           replace the tag if exists
    --create-reflog       create a reflog

Tag listing options
    --column[=<style>]    show tag list in columns
    --contains <commit>   print only tags that contain the commit
    --no-contains <commit>
                          print only tags that don't contain the commit
    --merged <commit>     print only tags that are merged
    --no-merged <commit>  print only tags that are not merged
    --sort <key>          field name to sort on
    --points-at <object>  print only tags of the object
    --format <format>     format to use for the output
    --color[=<when>]      respect format colors
    -i, --ignore-case     sorting and filtering are case insensitive
```

Git supports two types of tags: lightweight and annotated:
  1) git tag \<tagname\>
  2) git tag -a \<tagname\> -m \<message\>

### `git tag`

### `git tag -l`

### `git tag --list`

### `sharing tags`
By default, the git push command doesn’t transfer tags to remote servers. You will have to explicitly push tags to a shared server after you have created them. This process is just like sharing remote branches — you can run git push origin \<tagname\>.

If you have a lot of tags that you want to push up at once, you can also use the --tags option to the git push command. This will transfer all of your tags to the remote server that are not already there.

### `Checking out Tags`

git checkout \<tagname\>