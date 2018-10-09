#! /bin/sh
# 
# 2018-09-30 for use in vim
SNIP=$1
pandoc $SNIP --metadata=macros -o $HOME/Downloads/temp.pdf
mupdf $HOME/Downloads/temp.pdf &
sleep 0.2
rm    $HOME/Downloads/temp.pdf
return $SNIP
