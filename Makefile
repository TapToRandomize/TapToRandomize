all: dq3hf cotm-randomizer archipelago-mister mbc taptorandomize

dq3hf:
	cd vendor/dq3hf && make
cotm-randomizer:
	cd vendor/cotm-randomizer/Program && make
archipelago-mister:
	cd vendor/ArchipelagoMiSTer/ && python -m venv .venv && . .venv/bin/activate && python setup.py build -y
mbc:
	cd vendor/mbc && cc -static -o mbc mbc.c
taptorandomize:
	mkdir -p build/TapToRandomize && cp randomizerlauncher* build/TapToRandomize/ 
	cp -R vendor/dq3hf build/TapToRandomize/randomizers/
	cp -R vendor/cotm-randomizer build/TapToRandomize/randomizers/
	cp -R vendor/ArchipelagoMiSTer/build/exe.* build/TapToRandomize/randomizers/
	mv build/TapToRandomize/randomizers/exe.* build/TapToRandomize/archipelago-0.5.0-MiSTerFPGA
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
	cp -R vendor/shadowrun-rando build/TapToRandomize/randomizers/
	cp -R vendor/zelda-randomizer build/TapToRandomize/randomizers/
	cp -R vendor/zilliandomizer build/TapToRandomize/randomizers/
	cp vendor/mbc/mbc build/TapToRandomize
	cd build && zip -r TapToRandomize-0.2.1.zip TapToRandomize/
clean:
	cd vendor/dq3hf && make clean
	cd vendor/cotm-randomizer/Program && make clean
	rm -Rf vendor/ArchipelagoMiSTer/build
	rm -f vendor/mbc/mbc
	rm -Rf build
