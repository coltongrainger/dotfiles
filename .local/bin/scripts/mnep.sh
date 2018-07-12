#!/bin/bash
#
# Scour for ALLCAPS! and generate tabbed files for mnemosyne import

MNEMO_DIR=/home/colton/rote/mnemosyne/
OUTPUT=$MNEMO_DIR$(date +%F).txt

sed -e '/^[[:upper:]]\{2,\}\! /!d'\
    -e 's/\.\.\./<\/latex>\t<latex>/g'\
    -e '/^$/d'\
    -e 's/^/<latex>/g'\
    -e 's/$/<\/latex>/g'\
    $1 >> $OUTPUT
