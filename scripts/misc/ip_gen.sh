#! /bin/bash

# generates a list of IP addresses in a /24 CIDR

START="$1"
OUT="ips.txt"

# validate argument
if [[ "$START" == "" ]]; then
    echo "invalid invocation, start must contains the first three octets"
    exit 1
fi

# cleanup previous contents, silencing errors
rm "$OUT" > /dev/null 2>&1

for i in `seq 1 255`; do
    echo "$START.$i" >> "$OUT"
done
