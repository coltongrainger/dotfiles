#!/bin/bash

# pv.sh
# latexmk replacement 
# 2019-04-10

file="${1%.*}.pdf"
mupdf -r $file
