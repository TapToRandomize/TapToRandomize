Build Environment: If you're building for MiSTerFPGA and not trying to port this somewhere, it's easiest to build on a Raspberry Pi running 32 bit Raspbian Legacy (the Debian Bullseye version).

First, you'll need build-deps for Python. Easiest way to do that is:

sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

Next, install pyenv:

curl https://pyenv.run | bash

Then use pyenv to install python 3.9.6:

pyenv install 3.9.6

in whatever directory you're cloning your repo, do:

pyenv local 3.9.6

Now, you're ready to clone the repo. Do so:

git clone https://github.com/akerasi/TapToRandomize.git

Now, get into that directory, and update your submodules:

cd TapToRandomize
git submodule init
git submodule update
cd vendor/dqh3
git submodule init
git submodule update
cd ../../

Yes, one of our submodules has a submodule, so we needed to init that too. Now that all that's done... it's just make:

make

After waiting a long time, you'll have a built dir, and a zip, under build/ . Enjoy!