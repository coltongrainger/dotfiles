#! /bin/sh
#
# two-sided-scan.sh
# 2018-08-22
# CC0 Public Domain

scanimage\
    -d imagescan:esci:usb:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0\
    --resolution 300\
    --scan-area Letter/Portrait\
    --mode Monochrome\
    --threshold 150\
    --batch=$(date +%Y%m%d_%H%M%S)_p%04d.tiff\
    --duplex\

convert *.tiff $(date +%Y-%m-%d).pdf

rm *.tiff

mv --backup=t $(date +%Y-%m-%d).pdf $HOME/raw 

mupdf $HOME/raw/$(date +%Y-%m-%d).pdf &
