#!/bin/bash

file=$1
tmp=${file%.*}
year=${tmp##*-}

mv $file "$year-${file%-*}.${file#*.}"
