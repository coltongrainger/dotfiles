#! /bin/sh
#
# litup.sh
# 2018-09-03
# CC0 Public Domain

cd $HOME/lit

echo "---\ntitle: Primary and secondary sources\ndate: $(date -I)\n---\n\n
This content is intended for research, teaching, or classroom use (in the spirit of Erickson's <http://jeffe.cs.illinois.edu/pubs/copyright.html>). I have enabled [annotations](https://web.hypothes.is/) by [via proxy](https://web.hypothes.is/help/what-is-the-via-proxy/). To just see the file, know that, for example, `1962-tolstov-fourier-series.pdf` is hosted here <http://quamash.net/1962-tolstov-fourier-series.pdf>.\n\n" > index.md
echo "" > catalog

# TODO add error message if rsync fails or file is corrupt
for i in *pdf *djvu *epub; do
      rsync -v $i colton@quamash.net:/home/colton/wiki/static
      file=${i##*/}
      file_size=$(du -h "$file" | cut -f1)
      file_title="[$file](https://via.hypothes.is/http://quamash.net/$file)"
      echo "- $file_title ($file_size)" >> catalog
done

sort -r catalog >> index.md
rm catalog
mv index.md $HOME/wiki/quamash/lit.md

git -C /home/colton/wiki/quamash/ add /home/colton/wiki/quamash/lit.md
git -C /home/colton/wiki/quamash/ commit -m "Refresh lit index"
git -C /home/colton/wiki/quamash/ pushall
