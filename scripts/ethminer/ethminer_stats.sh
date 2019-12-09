#! /bin/bash


#  Used primarily by zabbix agent to parse the ethminer api into a consumable format
API_PORT="6767"

case "$1" in 

    miner_getstat1)
        echo '{"id":17,"jsonrpc":"2.0","method":"miner_getstat1"}'  |  netcat "$2" 6767
        ;;
    hashes)
        echo '{"id":17,"jsonrpc":"2.0","method":"miner_getstat1"}'  |  netcat "$2" 6767 | awk '{print $1}' | awk -F ',' '{print $5}' | tr -d '"' | awk -F ';' '{print $1}'
        ;;
    megahashes)
        hashes=$(echo '{"id":17,"jsonrpc":"2.0","method":"miner_getstat1"}'  |  netcat "$2" 6767 | awk '{print $1}' | awk -F ',' '{print $5}' | tr -d '"' | awk -F ';' '{print $1}')
        echo $((hashes / 1000))
        ;;
    *)
        echo "Invalid invocation"
        echo "./ethminer_stats.sh [miner_getstat1 | hashes | megahashes] <host-ip>"
        exit 1
        ;;
esac






### API output from miner_getstat1
#"9.3 - ETH"				- miner version.
#"21"					- running time, in minutes.
#"182724"				- total ETH hashrate in MH/s, number of ETH shares, number of ETH rejected shares.
#"30502;30457;30297;30481;30479;30505"	- detailed ETH hashrate for all GPUs.
#"0;0;0"					- total DCR hashrate in MH/s, number of DCR shares, number of DCR rejected shares.
#"off;off;off;off;off;off"		- detailed DCR hashrate for all GPUs.
#"53;71;57;67;61;72;55;70;59;71;61;70"	- Temperature and Fan speed(%) pairs for all GPUs.
#"eth-eu1.nanopool.org:9999"		- current mining pool. For dual mode, there will be two pools here.
#"0;0;0;0"				- number of ETH invalid shares, number of ETH pool switches, number of DCR invalid shares, number of DCR pool switches.
###