#!/bin/bash
#
# pc.sh
# latexmk replacement
# 2019-04-10

# return errors
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

textobject=$(realpath $1)
pdfobject="${textobject%.*}.pdf"
location=$(dirname $textobject)

echo "TEXTOBJECT $textobject"
echo "PDFOBJECT $pdfobject"
echo "LOCATION $location"

options="--pdf-engine=latexmk \
	--pdf-engine-opt=-pdf \
	--filter pandoc-citeproc \
	--bibliography=$HOME/coltongrainger.bib \
	--fail-if-warnings"

pandoc $textobject $options -o $pdfobject

echo "WATCHING $textobject"

inotifywait -m -e modify,close_write,moved_to $location | \
	while read path action file; do
		if [[ $(realpath $file) = $textobject ]]; then 
			pandoc $textobject $options -o $pdfobject
			pkill -HUP mupdf
			echo "COMPILED $action $file"
		else
			echo "-------- $action $file"
		fi
	done
