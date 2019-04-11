#!/bin/bash

# pc.sh
# latexmk replacement
# 2019-04-10

textobject=$1
location=$(dirname $textobject)
echo "OBJECT   ${textobject}"
echo "LOCATION ${location}"

inotifywait \
	-m -r -e modify,close_write,moved_to $location | \
while read path action file; do
	if [[ ${file} = *.md ]]; then 
		pc="pandoc ${location}/${file} \
			--pdf-engine=latexmk \
			--pdf-engine-opt=-pdf 
			--verbose \
			--filter pandoc-citeproc \
			--bibliography=/home/colton/coltongrainger.bib \
			-o ${location}/${file%.*}.pdf"
		$($pc)
		pkill -HUP mupdf
		echo "COMPILED ${action} ${file}"
	else
		echo "--------" "${action} ${file}"
	fi
done
