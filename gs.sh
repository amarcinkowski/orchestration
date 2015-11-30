#!/bin/bash

for D in repo/*; 
do
  if [ -d "${D}" ]; then
	echo "== GIT STATUS ${D}"
	git -C "${D}" status | grep -v "On branch master" | grep -v "Your branch is up-to-date" | grep -v "nothing to commit"
  fi
done
