#!/bin/bash

to_sync="$(readlink -f .)"/
google_drive_dir="$HOME/fy/20/siparcs/team-drive"
options="-v -u\
    --checkers 1\
    --transfers 4\
    --drive-skip-gdocs\
    --fast-list
    --exclude-from $google_drive_dir/.exclude"

case $to_sync
    in $google_drive_dir*)
        rclone sync $options "$to_sync" "sia-remote:${to_sync#$google_drive_dir*}" # --dry-run
    ;; esac
