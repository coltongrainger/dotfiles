#!/bin/bash
#
# Scour for ALLCAPS! and generate .csv files for mnemosyne import

MNEMO_DIR=/home/colton/rote/mnemosyne/
OUTPUT=$MNEMO_DIR$(date +%F).txt

sed -e '/^[[:upper:]]\{2,\}\! /!d'\
#    -e 's/^[[:upper:]]\{2,\}\! //g'\
    -e 's/ \.\.\. /<\/latex>\t<latex>/g'\
    -e '/^$/d'\
    -e 's/^/<latex>/g'\
    -e 's/$/<\/latex>/g'\
    $1 >> $OUTPUT
