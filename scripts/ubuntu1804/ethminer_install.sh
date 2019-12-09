#! /bin/bash

# Used to install ethminer from source optimized for nvidia

cd ~ || exit

echo "[INFO] Downloading ethminer"
git clone https://github.com/ethereum-mining/ethminer.git
cd ethminer || exit

echo "[INFO] Installing dbus development libraries"
sudo apt install libdbus-1-dev -y
echo "[INFO] Installing cmake"
sudo apt install cmake -y

echo "[INFO] Running GCC fix for ubuntu 18.04"
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 10

echo "[INFO] Updating submodules"
git submodule update --init --recursive
echo "[INFO] Creating build dir"
mkdir build
cd build || exit

echo "[INFO] Configuring cmake with options -DETHASHCUDA=ON -DETHASHCL=OFF -DAPICORE=ON -DBINKERN=OFF"
# we are omitting any special builds right now as there is a bug
# see the issue https://github.com/ethereum-mining/ethminer/issues/1473
cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DAPICORE=ON -DBINKERN=OFF # -DETHDBUS=ON

echo "[INFO] Building ethminer project"
cmake --build .

echo "[INFO] Installing ethminer"
sudo make install