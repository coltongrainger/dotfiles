#! /bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    /usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME add $line
done < "$1"
