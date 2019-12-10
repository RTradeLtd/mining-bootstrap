# Mining Bootstrap [![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FRTradeLtd%2Fmining-bootstrap.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FRTradeLtd%2Fmining-bootstrap?ref=badge_shield)

This repository contains a collection of scripts, systemd services, and generalized tooling for running a mining farm operation at scale. Additionally it includes a handy tool for generating earning reports for your farm on a select list of mining pools.


## ansible

Contains ansible playbooks useful for automating common mining farm tasks.

* `miner_watcher.yml` is used to copy our miner service watcher to our hosts
* `resolve.yml` is used to overwrite the systems `/etc/resolve.conf` file

## earnings-report

Utility is used to parse and process information from mining pools to keep your financial books up to date. This is particularly useful in Canada for large scale mining farms. In Canada if you are small scale, and not operating under a business mining profits are tax free (this isn't official tax advice, please consult a paid tax proffessional for legal advice) however large scale, and as a busines this is not the case. Using `earnings-report` you can confidently ensure your financial books are kept up to date.

Support pools:

* [x] MiningPoolHub
* [x] Ethermine (ETC+ETH)
* [x] Ethpool
* [x] Flypool (ZCash)

Please consult the readme within `earnings-report` for more information
Additional pools will be added over time.

## heaty-boi

Your dependable, friendly heaty boi. Used to regulate GPU temperatures automatically without human intervention

## scripts

various scripts to install, manage, and monitor mining rigs. See readme in scripts directory for more detailed information

## service_files

various systemd service files for mining rigs

## software

precompiled miner daemons, optimized for nvidia machines

## zabbix

zabbix related files to assist with rig monitoring

## Troubleshooting Resources

### Ethereum Mining Troubleshooting

* [low hash rate gtx 1060](https://github.com/ethereum-mining/ethminer/issues/314)

