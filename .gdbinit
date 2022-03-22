shell if test -f "$HOME/.gdbinit.before"; then \
            echo 'source "$HOME/.gdbinit.before"'; \
      fi > /tmp/.gdbinit
source /tmp/.gdbinit

# Source all settings from the peda dir
source ~/gits/pwndbg/gdbinit.py

# When inspecting large portions of code the scrollbar works better than 'less'
set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on

shell if test -f "$HOME/.gdbinit.after"; then \
            echo source "$HOME/.gdbinit.after"; \
      fi > /tmp/.gdbinit
source /tmp/.gdbinit
