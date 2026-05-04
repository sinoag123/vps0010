#!/bin/bash

WORKDIR="/workspaces/vps0010/sing-box-1.10.1-linux-amd64"
CONFIG="$WORKDIR/config.json"
LOG="$HOME/singbox.log"

cd "$WORKDIR" || exit 1

echo "=== watchdog started at $(date) ===" >> "$LOG"

# 防重复
pgrep -f watchdog-singbox.sh > /dev/null && exit 0

while true; do
    if ! pgrep -x sing-box > /dev/null; then
        echo "$(date) - sing-box not running, starting..." >> "$LOG"
        
        ./sing-box run -c "$CONFIG" >> "$LOG" 2>&1 &
        
        sleep 5
    fi

    sleep 10
done
