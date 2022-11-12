#!/bin/sh
# Prepare environment:
# - Start xserver for wine
# - Start MT5
# - Open VNC (can be modified for differnt observability)

set -e

/docker/run_xvfb.sh &
/docker/run_mt5.sh &
/docker/run_vnc.sh &

# Wait end of all wine processes
/docker/waitonprocess.sh wineserver