#!/usr/bin/env bash

# Break script on any non-zero status of any command
set -e

x11vnc -bg -nopw -rfbport 5900 -forever -xkb -o /tmp/x11vnc.log &
XVNC_PID=$!
sleep 15

echo "Start waiting on vnc be closed"
# while pgrep x11vnc >/dev/null; do
#     echo "... vnc on"
#     sleep 5;
# done

#ehco "start ...."; while pgrep x11vnc >/dev/null; do echo " ..... " sleep 5; done;

# Wait end of all wine processes
# /docker/waitonprocess.sh wineserver

