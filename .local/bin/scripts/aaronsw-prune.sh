#! /bin/bash

sed -i '/"by Aaron Swartz">Raw Thought/d' $1
sed -i '/style="float: right"/d' $1
sed -i '/You should follow me on twitter/d' $1
sed -i -n '/javascript/q;p' $1
echo "</body></html>" >> $1

