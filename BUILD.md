Build Environment: If you're building for MiSTerFPGA and not trying to port this somewhere, it's easiest to build on a Raspberry Pi running 32 bit Raspbian Legacy (the Debian Bullseye version).

You'll be manually building a new version of CMake by hand, so you can build randstalker. For that, you'll need cmake build deps. Make sure you've got a deb-src tree in your sources.list (uncomment the line in /etc/apt/sources.list) first.

```
sudo vim /etc/apt/sources.list
```

Uncomment the last line in there, then

sudo apt update && sudo apt build-dep cmake

Then make a tmpdir (I call mine ~/build), cd into it, and wget. I used this line:
```
wget https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2.tar.gz
tar -xvzf cmake-3.30.2.tar.gz
cd cmake-3.30.2
./bootstrap && gmake && sudo gmake install
```
(this will take a LOOOOOOOOONG time on a Pi 2 like mine. We're talking hours. Really. Might be faster on a newer Pi)

You'll also be building your Python by hand, using pyenv. Start by getting build-deps for Python. Easiest way to do that is:

sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

If we just did build-dep it'd miss some optional things we want.

Next, install pyenv:

```
curl https://pyenv.run | bash
```

Then use pyenv to install python 3.9.6:

```
pyenv install 3.9.6
```

in whatever directory you're cloning your repo, do:

```
pyenv local 3.9.6
```

Now, you're ready to clone the repo. Do so:

```
git clone https://github.com/akerasi/TapToRandomize.git
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