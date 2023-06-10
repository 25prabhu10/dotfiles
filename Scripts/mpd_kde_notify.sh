#!/usr/bin/env bash

# announce current song playing in mpd in a KDE notification

# icon support for passivepopup is implemented in more recent versions of KDE
mpd_music_folder_path_=$(mpc -f %file% | head -n1 | sed 's/\(.*\)\/.*\..\+$/\/run\/media\/prabhu\/Vinayak\/Music\/\1/')
mpd_music_icon_file_=$(find "$mpd_music_folder_path_" -type f -iregex '.*\.\(png\|jpg\|jpeg\|gif\|bmp\)$' -print | head -n1)
mpd_music_notif_=$(mpc current --format "%title%")

kdialog --icon "$mpd_music_icon_file_" --title "$mpd_music_notif_" --passivepopup "" 3
