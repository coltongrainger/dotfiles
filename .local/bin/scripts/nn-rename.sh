#! /bin/sh
#
# nn-rename.sh
# 2018-08-21
# CC0 Public Domain

date=$(grep "date:" $1 | cut -c 7-16)
mv $1 $date-${1%*.*}.md
