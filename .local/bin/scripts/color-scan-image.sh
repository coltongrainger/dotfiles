#! /bin/bash
#
# color-scan-image.sh
# 2019-06-27
# CC-0 Public Domain

scanimage\
    -d imagescan:esci:usb:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0\
    --resolution 300\
    --blank-threshold 0\
    --scan-area Letter/Portrait\
    --mode Color\
    --threshold 0\
    --batch=$(date +%Y%m%d_%H%M%S)_p%04d.tiff\

convert *.tiff $(date +%Y-%m-%d).pdf

rm *.tiff

mv --backup=t $(date +%Y-%m-%d).pdf $HOME/raw 

mupdf $HOME/raw/$(date +%Y-%m-%d).pdf &
