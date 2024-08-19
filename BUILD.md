Build Environment: If you're building for MiSTerFPGA and not trying to port this somewhere, it's easiest to build on a Raspberry Pi running 32 bit Raspbian Legacy (the Debian Bullseye version).

Truly fast way: Log into your raspberry pi, be in a dir you don't mind TapToRandomize living under, and...

```
git clone https://github.com/TapToRandomize/TapToRandomize.git && cd TapToRandomize && sudo bash ./setup_build_environment.sh && git submodule update --init --recursive && make
```

It'll still take about 3 and a half hours on a pi4, or 7 on a pi2, but at least then it can be unattended for that time.

Easy way: I've now made a buildscript that should handle all of the environment. Just clone the repo, get into it, and run the script:

```
git clone https://github.com/TapToRandomize/TapToRandomize.git
cd TapToRandomize
sudo bash ./setup_build_environment.sh
```

On a Raspberry Pi 2, this will take something around 6 hours. No that's not a typo. On a Raspberry Pi 4, about 3 hours. Again, not a typo. Why so long? Mostly, compiling cmake and Python 3.9.6 from source.

We still need to get our submodules:

```
git submodule update --init --recursive
```

This'll get all the submodules. There's a lot; this is mostly a repackaging project, after all.

Now that all that's done... it's just make:

```
make
```

HARD/ORIGINAL WAY (in case you want to learn):

You'll be manually building a new version of CMake by hand, so you can build randstalker. For that, you'll need cmake build deps. Make sure you've got a deb-src tree in your sources.list

```
sudo echo 'deb-src http://raspbian.raspberrypi.org/raspbian/ bullseye main contrib non-free rpi' >> /etc/apt/sources.list
```

That'll add that to your sources. Then,

```
sudo apt update && sudo apt build-dep cmake -y
sudo apt install libssl-dev -y
```

Then make a tmpdir (I call mine ~/build), cd into it, and wget. I used this line:
```
wget https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2.tar.gz
tar -xvzf cmake-3.30.2.tar.gz
cd cmake-3.30.2
./bootstrap --no-debugger && gmake && sudo gmake install
```
(this will take a LOOOOOOOOONG time on a Pi 2 like mine. We're talking hours. Really. Have also done it on my Pi4 now, "only" takes about 90 minutes there.)

You'll also be building your Python by hand, using pyenv. Start by getting build-deps for Python. Easiest way to do that is:

```
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
```

If we just did build-dep it'd miss some optional things we want.

Next, install pyenv:

```
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >> ~/.profile
. ~/.profile
```

Then use pyenv to install python 3.9.6:

```
pyenv install 3.9.6
```

in whatever directory you're cloning your repo, do:

```
mkdir ~/randorepos
cd ~/randorepos
pyenv local 3.9.6
```

The build environment is now complete; you should only have to do anything above this line once.

Now, you're ready to clone the repo. Do so:

```
git clone https://github.com/TapToRandomize/TapToRandomize.git
```

Now, get into that directory, and update your submodules:

```
cd TapToRandomize
git submodule update --init --recursive
```

This'll get all the submodules. There's a lot; this is mostly a repackaging project, after all.

Now that all that's done... it's just make:

```
make
```

After waiting a long time, you'll have a built dir, and a zip, under build/ . Enjoy!
