#!/bin/bash

to_sync="$(readlink -f .)"/ 
google_drive_dir="$HOME/fy/20/siparcs/team-drive"
options="-v -u\
    --checkers 1\
    --transfers 4\
    --drive-export-formats link.html\
    --fast-list"

case $to_sync
    in $google_drive_dir)
        rclone sync $options "sia-remote:${to_sync#$google_drive_dir}" "$to_sync" #--dry-run 
    ;; esac
