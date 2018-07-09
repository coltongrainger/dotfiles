#! /bin/bash

html=$(grep '<p class="posted">[[:alpha:]+]\+[[:space:]+]\+[[:digit:]{1,2}]' $1)
temp=${html#*>}
longdate=${temp%<*}

yyyy=${longdate: -4}
mmm=${longdate:0:3}
temp=${longdate#*\ }
dd=${temp%,*}
shortdate="$dd $mmm $yyyy"

isodate=$(date --date="$shortdate" +%F)

mv -i $1 $isodate-$1
