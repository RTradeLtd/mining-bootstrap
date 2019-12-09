#! /bin/bash

# proactively handle system failure with mining rigs

while true; do
    echo "[INFO] checking stratum address not supported"
    OUT=$(sudo systemctl status miner | grep -c "Address family not supported by protocol")
    if [[ "$OUT" -gt 0 ]]; then
        echo "[ERROR] encountered ipv6 stratum addressing issue, restarting miner"
        sudo systemctl restart miner
    fi

    echo "[INFO] checking general miner service status"
    OUT=$(sudo systemctl is-active miner)
    if [[ "$OUT" == "inactive" ]]; then
        sudo systemctl restart miner
    fi

    sleep 30
done

