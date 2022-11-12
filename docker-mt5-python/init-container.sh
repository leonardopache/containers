#!/bin/sh
# Prepare environment:
# - Start xserver for wine
# - Start MT5
# - Open VNC (can be modified for differnt observability)

set -e

/docker/run_xvfb.sh &
XVFB_PID=$!
/docker/run_mt5.sh &
MT5_PID=$!
/docker/run_vnc.sh &
VNC_PID=$!

# Wait end of all wine processes
# /docker/waitonprocess.sh wineserver