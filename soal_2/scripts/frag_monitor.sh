#!/bin/bash

mkdir -p ./logs

LOG_FILE="./logs/fragment.log"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

TOTAL_MEM=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
AVAILABLE_MEM=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')

if [[ -z "$TOTAL_MEM" || -z "$AVAILABLE_MEM" ]]; then
    echo "Error: Unable to read memory info" >> "$LOG_FILE"
    exit 1
fi

USED_MEM=$((TOTAL_MEM - AVAILABLE_MEM))
TOTAL_MEM_MB=$((TOTAL_MEM / 1024))
AVAILABLE_MEM_MB=$((AVAILABLE_MEM / 1024))
USED_MEM_MB=$((USED_MEM / 1024))

RAM_USAGE=$(awk "BEGIN {printf \"%.2f\", ($USED_MEM / $TOTAL_MEM) * 100}")

LOG_ENTRY="[$TIMESTAMP] - Fragment Usage [$RAM_USAGE%] - Fragment Count [$USED_MEM_MB MB] - Details [Total: $TOTAL_MEM_MB MB, Available: $AVAILABLE_MEM_MB MB]"

echo "$LOG_ENTRY"

sleep 1

