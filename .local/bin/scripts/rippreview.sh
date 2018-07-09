#!/bin/bash

TRACK=$1
NAME=preview

STARTPOS=5:00
DUR=0:30

rm -f frameno.avi *.log

mencoder dvd://$TRACK -ovc frameno -o frameno.avi -oac copy \
         -alang en -ss $STARTPOS -endpos $DUR

mencoder dvd://1 -oac copy -o /dev/null -ovc lavc\
  -lavcopts vcodec=mpeg4:vbitrate=1000:vhq:vpass=1:vqmin=2:vqmax=31 \
  -ss $STARTPOS -endpos $DUR

mencoder dvd://1 -oac copy -o $NAME-$TRACK.avi -ovc lavc \
  -lavcopts vcodec=mpeg4:vbitrate=1000:vhq:vpass=2:vqmin=2:vqmax=31 \
  -ss $STARTPOS -endpos $DUR
