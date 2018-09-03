#! /bin/sh
#
# litup.sh
# 2018-09-03
# CC0 Public Domain

cd $HOME/lit

echo "---\ntitle: Literature\ndate: $(date -I)\n---\n"\
      > index.md
echo "" > catalog

# TODO add error message if rsync fails or file is corrupt
for i in *pdf *djvu *epub; do
      rsync -v $i colton@quamash.net:/home/colton/wiki/static
      file=${i##*/}
      file_size=$(du -h "$file" | cut -f1)
      file_title="[$file](/$file)"
      echo "- $file_title ($file_size)" >> catalog
done

sort catalog >> index.md
rm catalog
mv index.md $HOME/wiki/quamash/lit.md

git -C /home/colton/wiki/quamash/ add /home/colton/wiki/quamash/lit.md
git -C /home/colton/wiki/quamash/ commit -m "Refresh lit index"
git -C /home/colton/wiki/quamash/ pushall
