#!/bin/bash

# modified version of, does two things:
#   1) generates a list of online hosts
#   2) parses the hosts file to create a clusterssh scripts
# see https://security.stackexchange.com/a/95049

USER="$2"
MSG=""

nmap $1 -n -sP | grep report | awk '{print $5}' > hosts.txt

for i in $(cat hosts.txt); do
    msg="$msg $i"
done

echo -e "#! /bin/bash\nclusterssh --username $USER $msg" > cluster_ssh.sh
chmod a+x cluster_ssh.sh