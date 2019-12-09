#! /bin/bash

# the gpu to pull metrics from
SELECTED_GPU_NUMBER="$1"
# retrieves the total number of GPUs
GPU_COUNT=$(nvidia-smi --query-gpu=count --format=csv,noheader | head -n 1)
let MAX=$(($GPU_COUNT-1))
# make sure that a non-empty parameter was given
if [[ "$SELECTED_GPU_NUMBER" == "" ]]; then
    echo "[ERROR] No valid gpu number provided"
    echo "Invalid invocation"
    exit 1
fi

# we need to compare against 1 below maximum since gpu is indexed starting at 0
if [[ "$SELECTED_GPU_NUMBER" -gt "$MAX" ]]; then
    echo "[ERROR] provided gpu number greater than gpu count"
    exit 1
fi

MAX_TEMP=80
COUNTER=0
SLEEP_TIME=900
while [  $COUNTER -lt "$GPU_COUNT" ]; do
    TEMP=$(nvidia-smi -q -i "$COUNTER" | grep -i "GPU Current Temp" | awk -F ':' '{print $2}' | awk '{print $1}')
    echo "[INFO] Temperature for GPU $COUNTER is $TEMP"
    if [[ "$TEMP" -ge "$MAX_TEMP" ]]; then
        echo "[WARN] GPU Temperature is 80C or above, shutting down miner"
        systemctl stop miner
        echo "[WARN] Sleeping for $SLEEP_TIME seconds to cool chips down"
        sleep "$SLEEP_TIME"
        echo "[INFO] Starting up miners"
        systemctl start miner
    fi
    let COUNTER=COUNTER+1
    if [[ "$COUNTER" -eq "$GPU_COUNT" ]]; then
        COUNTER=0
    fi
done