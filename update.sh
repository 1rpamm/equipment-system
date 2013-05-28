#!/bin/bash

TIMESTAMP=$(date +"%Y\%m\%d %H:%M:%S")
COMMIT="small update" #~($TIMESTAMP)"

#~ git add .
#~ git rm -rf tmp/
#~ git commit -m "$COMMIT"
#~ git remote add origin git@github.com:1rpamm/equipment-system.git
#~ git push -u origin master

git add .
git rm -rf tmp/
git commit -m "$COMMIT"
git push -u origin master
#~ git push --force --progress origin master
