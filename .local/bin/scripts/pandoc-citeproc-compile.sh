#! /bin/bash
# 
# 2018-09-16 for use in vim
# 2019-04-09 added latexmk, based on 
# https://gist.githubusercontent.com/mmcclimon/7311538/

# pandoc
PANDOC_CMD="pandoc"
PANDOC_OPTS="-s --bibliography=/home/colton/coltongrainger.bib --filter pandoc-citeproc"

# latexmk
LATEXMK_CMD="latexmk"
LATEXMK_OPTS="-pvc -pdf"

path=$1
if [ -z "$path" ]
then
  echo "Must provide a path to file"
  exit 1
fi

name=$( basename $path )
ext=${name##*.}
if [ "$ext" != "md" ]
then
  echo "File must be a markdown file (with extension .md)"
  exit 1
fi

# command to run
basename=${name%.*}
tex="${basename}.tex"
cmd="${PANDOC_CMD} ${PANDOC_OPTS} -o ${tex} ${path}"

echo "Listening for changes to ${path}"
echo "Will run this command on change:"
echo "    ${cmd}"
echo "(Ctrl-C to exit)"
echo

eval $cmd

sleep 3

while true
do
   ATIME=`stat -c %Z ${path}`
   if [[ "$ATIME" != "$LTIME" ]]
   then
       eval $cmd
       LTIME=$ATIME
       pkill -HUP mupdf
   fi
   sleep 1
done &

eval "${LATEXMK_CMD} ${LATEXMK_OPTS} ${tex}"
