#! /bin/bash
#
# autostart.sh
# 2019-07-09
# CC-0 Public Domain

if pgrep -u colton nm-applet &> /dev/null;
then
  echo alive &> /dev/null
else
    nm-applet --sm-disable &
fi

if pgrep -u colton stalonetray &> /dev/null;
then
  echo alive &> /dev/null
else
    stalonetray&
fi

if pgrep -u colton cbatticon &> /dev/null; then
  echo alive &> /dev/null
else
  cbatticon -u 20 -c "zenity --warning --text 'battery low'" -l 30 -r 25&
fi

if pgrep -u colton udiskie &> /dev/null; then
  echo alive &> /dev/null
else
  udiskie -t --notify-command "zenity --info --text '{event}: {device_presentation}'" &
fi

if pgrep -u colton fluxgui &> /dev/null; then
  echo alive &> /dev/null
else
  fluxgui &
fi

if pgrep -u colton dropbox &> /dev/null; then
  echo alive &> /dev/null
else
  python $HOME/.local/dropbox.py start &
fi
