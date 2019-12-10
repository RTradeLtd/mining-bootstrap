# Scripts

Here you can find scripts for managing linux mining rigs running on Ubuntu. We use these scripts to manage our own rigs at our datacenter.

## Contents


* `ethminer/ethminer_start.sh` is used to start the ethminer software
* `ethminer/ethminer_stats.sh` is used to pull stats from the ethminer api
* `miner/miner_watcher.sh` is used to ensure the miner service never stalls
* `nvidia/nvidia_smi_parser.sh` is used to parse `nvidia-smi` output and retrieve common stats
* `nvidia/nvidia_temperature_watcher.sh` a configurable thermostat for your GPUs
* `misc/ip_gen.sh` is used to generate ip ranges in /24 networks
* `misc/live_hosts.sh` is used to generate a list of hosts online in a network and a clusterssh script to access all of them

### Ubuntu 18.04

These are scripts specifically for ubuntu 18.04 distributions

* `ethminer_install.sh` is used to install the ethminer software
* `nvidia_install.sh` is used to install nvidia drivers and is intended to be ran immediately after system installation

### Ubuntu 16.04 - No Longer Maintained

These are scripts specifically for ubuntu 16.04 distributions
