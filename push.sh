#!/bin/sh

chmod +x keepEmptyDir.sh
./keepEmptyDir.sh

git add .
git commit -m "1"
git push git@github.com:eit90123/typora.git
