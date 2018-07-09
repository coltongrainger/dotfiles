#!/bin/bash

file=$1
name=${file%.*}

mv $file $(sed 's/\./\-/g' <<< "$name").${file##*.}
