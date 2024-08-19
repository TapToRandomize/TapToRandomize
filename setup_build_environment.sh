#!/bin/bash
sudo echo 'deb-src http://raspbian.raspberrypi.org/raspbian/ bullseye main contrib non-free rpi' >> /etc/apt/sources.list
sudo apt update && sudo apt build-dep cmake -y
sudo apt install libssl-dev -y
mkdir build-deps-tmp
cd build-deps-tmp
wget https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2.tar.gz
tar -xvzf cmake-3.30.2.tar.gz
cd cmake-3.30.2
./bootstrap --no-debugger && gmake && sudo gmake install
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >> ~/.profile
. ~/.profile
pyenv install 3.9.6
cd ..
pyenv local 3.9.6
