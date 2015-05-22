#!/bin/bash

for D in *; 
do
  if [ -d "${D}" ]; then
	echo "== GIT STATUS ${D}"
	git -C "${D}" status
  fi
done
