dq3hf:
	cd vendor/dq3hf && make
cotm-randomizer:
	cd vendor/cotm-randomizer && make
archipelago-mister:
	cd vendor/ArchipelagoMiSTer/ && python -m venv .venv && source .venv/bin/activate && setup.py build -y
mbc:
	cd vendor/mbc && cc -static -o mbc mbc.c
taptorandomize:
	mkdir -p build/TapToRandomize && cp randomizerlauncher* build/TapToRandomize 
	cp -R vendor/dq3hf build/TapToRandomize/randomizers/dq3hf
	cp -R vendor/cotm-randomizer build/TapToRandomize/randomizers/cotm-randomizer
	cp -R vendor/ArchipelagoMiSTer/build/exe.* build/TapToRandomize/randomizers/archipelago-0.5.0-MiSTerFPGA
	cp mbc/mbc build/TapToRandomize
	cd build && zip TapToRandomize-0.2.1.zip TapToRandomize/
