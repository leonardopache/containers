#!/usr/bin/env bash
# Break script on any non-zero status of any command

export DISPLAY SCREEN_NUM SCREEN_WHD

XVFB_PID=0
TERMINAL_PID=0

Xvfb $DISPLAY -screen $SCREEN_NUM $SCREEN_WHD \
    +extension GLX \
    +extension RANDR \
    +extension RENDER \
    &> /tmp/xvfb.log &

XVFB_PID=$!
/docker/waitonprocess.sh Xvfb