#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Input the message, plz"
  echo "usage> ./g <message>"
  exit 0
fi

echo "git..."

git add --all

git commit -m "xxxx"

git push
