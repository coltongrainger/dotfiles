#! /bin/bash
#
# latex-help.sh
# 2019-04-15
# CC-0 Public Domain

read -p "docs? [d] macros? [m] " string

if [[ $string = *"d"* ]]
then 
  read -p "[x]ymatrix, [p]hysics, x[y]pic, [a]msmath, or ... ? " helpdoc
  if [[ $helpdoc = "x" ]]; then
    mupdf $HOME/texmf/tex/docs/xymatrix.pdf
  elif [[ $helpdoc = "y" ]]; then
    mupdf $HOME/texmf/tex/docs/xypic.pdf
  elif [[ $helpdoc = "a" ]]; then
    mupdf $HOME/texmf/tex/docs/amsmath.pdf
  elif [[ $helpdoc = "p" ]]; then
    mupdf $HOME/texmf/tex/docs/physics.pdf
  else
    ls $HOME/texmf/tex/docs/
    read -p "other docs? " otherdoc
    if [[ $otherdoc != "" ]]; then
      mupdf $HOME/texmf/tex/docs/$otherdoc.pdf
    fi
  fi
else
  cd $HOME/fy/19/stylefiles/src
  read -p "search? [else list all macros] " macro
  if [[ $macro != "" ]]; then
    grep --color=always -i -C 5 -r -E $macro * | less -R 
  else
    grep -i -r -E "(new|command|operator|theorem)" * | less
  fi
fi
