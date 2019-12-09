#! /bin/bash

# install that cuda goodness baby

if [[ "$(echo $(which git))" -eq "" ]]; then
    sudo apt install git -y
fi

cd ~
git clone git@github.com:RTradeLtd/mining-bootstrap.git
# download cuda 9
wget https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64
sudo dpkg -i cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64
sudo apt-key add /var/cuda-repo-9-2-local/7fa2af80.pub
sudo apt-get update -y
sudo apt-get install cuda-9.2 -y
# install updates
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update -y
sudo apt-get upgrade -y
# download ethminer
wget https://github.com/ethereum-mining/ethminer/releases/download/v0.15.0.dev11/ethminer-0.15.0.dev11-Linux.tar.gz
tar zxvf ethminer-0.15.0.dev11-Linux.tar.gz
# make out boot script directory
sudo mkdir /boot_scripts
sudo cp -r bin /boot_scripts
sudo cp /home/rtrade/mining-bootstrap/scripts/nvidia_smi_parser.sh /boot_scripts
sudo cp /home/rtrade/mining-bootstrap/scripts/ethminer_*.sh /boot_scripts
sudo chmod a+x /boot_scripts/*.sh
sudo cp /home/rtrade/mining-bootstrap/service_files/ethminer.service /etc/systemd/system
sudo systemctl enable ethminer.service
echo "[INFO] Sleeping for 20 seconds then rebooting"
echo "[INFO] Hit CTRL+C to cancel the script and stop reboot"
sleep 20
echo "[INFO] Rebooting now...."
sudo reboot now
