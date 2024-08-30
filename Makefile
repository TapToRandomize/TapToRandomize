all: dq3hf cotm-randomizer archipelago-mister mbc randstalker taptorandomize

dq3hf:
	cd vendor/dq3hf && make
cotm-randomizer:
	cd vendor/cotm-randomizer/Program && make
archipelago-mister:
	cd vendor/ArchipelagoMiSTer/ && python -m venv .venv && . .venv/bin/activate && python setup.py build -y
randstalker:
	cd vendor/randstalker/ && sh build_unix.sh
mbc:
	cd vendor/mbc && cc -static -o mbc mbc.c
taptorandomize:
	mkdir -p build/TapToRandomize && cp randomizerlauncher* build/TapToRandomize/
	mkdir -p build/TapToRandomize/randomizers/
	cp -R randomizers/* build/TapToRandomize/randomizers/
	cp -R vendor/dq3hf build/TapToRandomize/randomizers/
	cp -R vendor/cotm-randomizer build/TapToRandomize/randomizers/
	cp -R vendor/ArchipelagoMiSTer/build/exe.* build/TapToRandomize/randomizers/
	mv build/TapToRandomize/randomizers/exe.* build/TapToRandomize/randomizers/archipelago-0.5.0-MiSTerFPGA
	cp -R vendor/actraiser-randomizer build/TapToRandomize/randomizers/
	cp -R vendor/ALttPDoorRandomizer build/TapToRandomize/randomizers/
	cp -R vendor/bof3_vast_violence build/TapToRandomize/randomizers/
	cp -R vendor/ffl2mp build/TapToRandomize/randomizers/
	cp -R vendor/fftrctcr build/TapToRandomize/randomizers/
	cp -R vendor/GS-Randomizer build/TapToRandomize/randomizers/
	cp -R vendor/LADXR build/TapToRandomize/randomizers/
	cp -R vendor/MegamanRandomizer build/TapToRandomize/randomizers/
	cp -R vendor/mg-random build/TapToRandomize/randomizers/
	cp -R vendor/mn64rando build/TapToRandomize/randomizers/
	cp -R vendor/randstalker/build/ build/TapToRandomize/randomizers/
	mv build/TapToRandomize/randomizers/build build/TapToRandomize/randomizers/randstalker
	cp -R vendor/shadowrun-randomizer build/TapToRandomize/randomizers/
	cp vendor/mbc/mbc build/TapToRandomize/randomizers/
	mv build/TapToRandomize build/Scripts
	cd build && zip -r TapToRandomize-0.3.0.zip Scripts/
clean:
	cd vendor/dq3hf && make clean
	cd vendor/cotm-randomizer/Program && make clean
	rm -Rf vendor/ArchipelagoMiSTer/build
	rm -f vendor/mbc/mbc
	rm -Rf build
