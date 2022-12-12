#!/bin/sh
# Caps_Lock to Ctrl/Esc.

# for some reason, it seems like when you plug in a new keyboard and have to
# rerun the script, an older xcape process is active and the new one doesn't
# seem to work
pkill xcape
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
