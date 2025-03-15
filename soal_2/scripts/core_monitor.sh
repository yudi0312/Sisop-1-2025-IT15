#!/bin/bash

mkdir -p ./logs

LOG_FILE="./logs/core.log"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print $2 + $4}')

CPU_MODEL=$(lscpu | grep "Model name" | awk -F': ' '{print $2}')

if [[ -z "$CPU_USAGE" ]]; then
    CPU_USAGE="N/A"
fi

if [[ -z "$CPU_MODEL" ]]; then
    CPU_MODEL="Unknown CPU Model"
fi

LOG_ENTRY="[$TIMESTAMP] - Core Usage [$CPU_USAGE%] - Terminal Model [$CPU_MODEL]"

echo "$LOG_ENTRY"

sleep 1

