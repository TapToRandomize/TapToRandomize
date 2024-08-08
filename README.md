TapToRandomize is a simple script to automize randomizer usage on MiSTerFPGA, best utilized alongside TapTo (https://github.com/TapToCommunity/tapto)

Usage: randomizerlauncher.sh randomizername

In TapTo, make a card with **mister.script:randomizerlauncher.sh randomizername autolaunch?hidden=true||

Upon tapping that card, after a wait (note some waits can be sizeable, SMZ3 can take up to 4 minutes to launch!) your randomized ROM will start up. You get a freshly randomized ROM any time you tap the card; to save a session for later, open the ROM in the RandoDir/current directory via the normal MiSTerFPGA menus, or make a card with just the launch command above to launch whatever your current seed is without making a new one.

RandoDir for each randomizer is defined in the script or in a .ini file. It's set to sane defaults (at least for people who use a cifs drive like me; if your stuff is on an SD card, remove the cifs from all the configs)

A default ini file is included. You'll almost certainly need to edit it.

Each Archipelago-based randomizer (all of them but Solar Jetman right now) uses a yaml file, located in yamls, for some of its configs. There is a rewriter for these files, at randomizerlauncheryamls.ini, which is a Windows-style ini file rather than a flat Unix one. Sections do matter when editing it. What's in the .ini file will overwrite whatever is in the yamls.You will almost certainly need to edit the rom_path entries in the ini file. I don't recommend editing the .yaml files directly as the .ini will overwrite them, but if you want to, comment out the sections in the ini. Also don't forget to edit host.yaml if you're doing this; the .ini file takes care of that quietly for you, currently.

Weird config note: for Zillion specifically, your ROM MUST be named as Zillion (UE) [!].sms . It can live in any directory, but the filename MUST match that exactly. This is inherited from Archipelago, which inherited it from zilliandomizer, so nothing I can do to change it unless I want to fix it in zilliandomizer, and that's likely beyond my scope... for now. No other randomizers currently have a restriction like this.

This is EARLY Alpha at this point; it should progress as things go.

Supported randomizers currently:

(from akerasi https://github.com/akerasi/SJ-rando)

solarjetman (NES Solar Jetman)

(from Archipelago https://github.com/ArchipelagoMW/Archipelago)

alttp (SNES A Link To The Past)

dkc3 (SNES Donkey Kong Country 3)

cv64 (N64 Castlevania64)

kdl3 (SNES Kirby's Dream Land 3)

loz (NES The Legend of Zelda)

l2 (SNES Lufia 2 Ancient Caves)

mmbn3 (GBA Mega Man Battle Network 3)

pokerb (GB Pokemon Red and Blue)

smz3 (SNES Super Metroid and A Link to the Past Combo Randomizer)

soe (SNES Secret of Evermore)

sm (SNES Super Metroid)

yoshi (SNES Yoshi's Island)

yugioh06 (GBA Yu Gi Oh Ultimate Master 2006)

zillion (SMS Zillion)

Version: 0.1.3
Author: akerasi (Allen Tipper)

CHANGELOG:
0.1.4: Added autolaunch support, making cardlines easier to write, and added a working menu system for those without TapTo. Now works fine when launched from the MiSTer Scripts menu, and launches the rom when done building.

0.1.3: Added Zillion support, refactored directory structure so everything lives under one directory, randomizers, other than the main script and its two ini files.

0.1.2: Added YAML rewriter to handle Archipelago config YAMLs in a saner manner.

0.1.1: Initial release.