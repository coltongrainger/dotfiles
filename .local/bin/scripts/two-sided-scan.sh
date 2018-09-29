#! /bin/sh
#
# two-sided-scan.sh
# 2018-08-22
# CC0 Public Domain

scanimage\
    -d imagescan:esci:usb:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0\
    --resolution 225\
    --blank-threshold 10\
    --scan-area Letter/Portrait\
    --mode Monochrome\
    --threshold 150\
    --batch=$(date +%Y%m%d_%H%M%S)_p%04d.tiff\
    --duplex\

convert *.tiff $(date +%Y-%m-%d).pdf

rm *.tiff

mv --backup=t $(date +%Y-%m-%d).pdf $HOME/raw 

mupdf $HOME/raw/$(date +%Y-%m-%d).pdf &

# Options specific to device `imagescan:esci:usb:/sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0':
#   General:
#     --duplex[=(yes|no)] [no]
#         Duplex
#     --resolution 50..600dpi [300]
#         Resolution
#     --scan-area Executive/Portrait|ISO/A4/Portrait|ISO/A5/Portrait|ISO/A5/Landscape|ISO/A6/Portrait|ISO/A6/Landscape|JIS/B5/Portrait|JIS/B6/Portrait|JIS/B6/Landscape|Legal/Portrait|Letter/Portrait|Manual|Maximum|Auto Detect [Manual]
#         Scan Area
#     --mode Monochrome|Grayscale|Color [Color]
#         Image Type
#   Geometry:
#     -x 50.8..218.186mm [218.186]
#         Width of scan-area.
#     -y 50.8..368.3mm [368.3]
#         Height of scan-area.
#     -l 0..218.186mm [0]
#         Top Left X
#     -t 0..368.3mm [0]
#         Top Left Y
#   Enhancement:
#     --dropout Blue|Green|Red|None [inactive]
#         Dropout
#     --force-extent[=(yes|no)] [yes]
#         Force the image size to equal the user selected size.  Scanners may
#         trim the image data to the detected size of the document.  This may
#         result in images that are not all exactly the same size.  This option
#         makes sure all image sizes match the selected area.
#         Note that this option may slow down application/driver side processing.
#     --deskew[=(yes|no)] [no]
#         Deskew
#     --rotate 0 degrees|90 degrees|180 degrees|270 degrees|Auto [0 degrees]
#         Rotate
#     --blank-threshold 0..100 [0]
#         Skip Blank Pages Settings
#     --brightness -100..100 [0]
#         Change brightness of the acquired image.
#     --contrast -100..100 [0]
#         Change contrast of the acquired image.
#     --threshold 0..255 [128]
#         Threshold
#   Other:
#     --gamma 1.0|1.8 [1.8]
#         Gamma
#     --image-count 0..999 [0]
#         Image Count
#     --jpeg-quality 1..100 [90]
#         JPEG Quality
#     --long-paper-mode[=(yes|no)] [no]
#         Select this mode if you want to scan documents longer than what the
#         ADF would normally support.  Please note that it only supports
#         automatic detection of the document height.
#     --overscan[=(yes|no)] [no]
#         Overscan
#     --transfer-size 1..1048576 [1048576]
#         Transfer Size
