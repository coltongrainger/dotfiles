#! /bin/sh
# 
# 2018-09-16 for use in vim
pandoc $1 --filter pandoc-citeproc -o ${1%.*}.pdf
