#! /bin/sh
#
# math6220-compile.sh
# 2019-01-14
# CC0 Public Domain

pandoc -s --filter pandoc-citeproc -o ${1%.*}.tex $1 --template=amsart.latex -f markdown-auto_identifiers 
sleep .5
latexmk -pdf ${1%.*}.tex
latexmk -c ${1%.*}.tex
