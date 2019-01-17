#! /bin/sh
#
# hw-rename.sh
# 2019-01-15
# CC0 Public Domain

date=$(grep date $1 | grep -Eo '[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}')
mv $1 $date-${1#*-}
