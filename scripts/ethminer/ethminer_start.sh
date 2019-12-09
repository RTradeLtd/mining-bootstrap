#! /bin/bash

USERNAME="..."
WORKER_NAME=$(hostname)
PORT="4444"
URL="stratum+tcp://$USERNAME.$WORKER_NAME:x@us1.ethermine.org:$PORT"
API="no"

if [[ "$API" == "yes" ]]; then
	    ethminer -U -P "$URL" --api-port -6767 2>&1 | tee --append "$HOME/ethminer.log"
    else
	        ethminer -U -P "$URL" 2>&1 | tee --append "$HOME/ethminer.log"
fi
