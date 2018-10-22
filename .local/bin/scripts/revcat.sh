#!/usr/bin/env bash
#
# revcat.sh
# 2018-10-21
# CC0 Public Domain

outarray=()

for x in $(seq $1 -1 0); do
    if [ -e $HOME/raw/$(date --date="$x days ago" -I).pdf ]
        then
            outarray+=($HOME/raw/$(date --date="$x days ago" -I).pdf)
    fi
done

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress\
    -sOutputFile=$HOME/Downloads/temp.pdf ${outarray[@]}

mupdf $HOME/Downloads/temp.pdf
wait
rm $HOME/Downloads/temp.pdf
