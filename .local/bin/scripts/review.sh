#!/usr/bin/env bash
#
# review.sh
# 2018-08-28
# CC0 Public Domain

for x in $(seq $1 -1 0); do
    notes=$(date --date="$x days ago" -I).pdf
    mupdf $HOME/raw/$notes
done
