#!/bin/bash

# pv.sh
# latexmk replacement 
# 2019-04-10

textobject=$(realpath $1)
mupdf "${textobject%.*}.pdf"
