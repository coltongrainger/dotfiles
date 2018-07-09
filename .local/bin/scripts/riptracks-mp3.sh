#!/bin/bash

NAME=track

for TRACK in $*;
do
 rm -f frameno.avi *.log

 if [ -f $NAME-$TRACK.avi ]; then
     echo "$NAME-$TRACK.avi exists; please remove."
     exit
 fi

 mencoder dvd://$TRACK -ovc frameno -o frameno.avi -oac mp3lame \
   -lameopts vbr=4 -alang en 

 
 mencoder dvd://$TRACK -oac mp3lame -lameopts vbr=4 -o /dev/null \
  -ovc lavc \
  -lavcopts \
   vcodec=mpeg4:vbitrate=1000:vhq:vpass=1:vqmin=2:vqmax=31:autoaspect=1 \
  -alang en 

 mencoder dvd://$TRACK -oac mp3lame -lameopts vbr=4 -o $NAME-$TRACK.avi \
  -ovc lavc \
  -lavcopts \
   vcodec=mpeg4:vbitrate=1000:vhq:vpass=2:vqmin=2:vqmax=31:autoaspect=1  \
  -alang en 

done
