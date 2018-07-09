#! /bin/bash

test
sed -i '/stylesheet/,/main section/d' $1
sed -i '/blog-pager/,$d' $1
echo "</body></html>" >> $1
