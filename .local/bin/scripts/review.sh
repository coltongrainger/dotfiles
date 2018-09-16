#!/usr/bin/env bash
#
# review.sh
# 2018-08-28
# CC0 Public Domain

for x in {30..0}; do
    notes=$(date --date="$x days ago" -I).pdf
    mupdf $HOME/raw/$notes
done
