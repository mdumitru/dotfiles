#!/bin/sh
# Caps_Lock to Ctrl/Esc.
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
