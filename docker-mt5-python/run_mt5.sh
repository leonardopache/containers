#!/usr/bin/env bash

# Break script on any non-zero status of any command
set -e

wine terminal64.exe /portable &
TERMINAL_PID=$!

# Wait end of terminal
wait $TERMINAL_PID