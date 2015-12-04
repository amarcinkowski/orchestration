#!/bin/bash
function clone_repos {
  sudo rm -rf $APP_DIR $REPO_DIR/*
  sudo apt-get -y install git
  echo "CLONE REPOS: ${@}"
  for i in "${@}"
  do
    echo "PROJECT $i (https://github.com/$i)"
    git clone https://github.com/$i $REPO_DIR/${i##*\/}
  done
  sudo rm -rf $APP_DIR
  sudo ln -s $REPO_DIR/hospitalpage $APP_DIR
}

function replace_lib_with_git {
  rm -rf $1
  echo "removing $1"
  ln -s ~/repo/$2 $1
  echo "replacing ${1} with ~/repo/$2"
}

