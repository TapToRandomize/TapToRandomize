TapToRandomize is a simple script to automate randomizer usage on MiSTerFPGA, best utilized alongside TapTo (https://github.com/TapToCommunity/tapto)

Build instructions are under Build.md, but if you're not a developer, you're better off just downloading the release, either directly or using update_all

Installation:

Unzip the release zip into /media/fat/Scripts
Alternately, on your MiSTer, add these lines to your downloader.ini on your SD card:


[TapToRandomize/TapToRandomizeDist]<br>
db_url = https://raw.githubusercontent.com/TapToRandomize/TapToRandomizeDist/db/db.json.zip


and run `update_all`

Once it's there, all you need to do is try to run a randomizer. First run will take a LOOONG time, like 20 minutes, finding your ROMs and building your initial .ini files; subsequent runs will be able to skip this step, and run much faster.

Command Line Usage: randomizerlauncher.sh randomizername

where "randomizername" is the short names of randomizers as below in this README. One can also add "autoload" to the end, so it looks like

`randomizerlauncher.sh solarjetman autoload`

to generate and run a Solar Jetman rom.

Without TapTo, you can also just open the script in the scripts menu, if you can view interactive scripts; it'll give you a list of randomizers, just select the one you want. The menu always is set to autoload ROMs; as a note, the menu ONLY works on a MiSTer, via HDMI; it will not properly function over SSH. I hope to fix that in a future release.

In TapTo, make a card with **mister.script:randomizerlauncher.sh randomizername autoload (in the near future add ?hidden=true to the end of it to surpress the display output for truly smooth operation).

Upon tapping that card, after a wait (note some waits can be sizeable, SMZ3 can take up to 4 minutes to launch! If you uncomment and try mn64, it took OVER AN HOUR to generate a rom, which is why I just commented it out; it "functions" if you do uncomment it) your randomized ROM will start up. You get a freshly randomized ROM any time you tap the card; to save a session for later, open the ROM in the RandoDir/current directory via the normal MiSTerFPGA menus, or make a card with a launch command targeting your RandoDir/current directory (I suggest having this card premade if you're in the habit of playing a single seed over multiple sessions).

RandoDir for each randomizer is defined in the script or in a .ini file. The config builder tries to find ROMs automatically; if you have the right ROM, it should find it and add it to the config. When in doubt, you probably want a 1.0 rom if there are multiple versions, and some randomizers want a JP rom, but most want a US one. Look up the original randomizers for more info.

A default ini file is included as an example, in case you want to look; it's the actual ini file I used before I made the autobuilder.

Each Archipelago-based randomizer (these have an appended -a at the end of their short names) uses a yaml file, located in yamls, for some of its configs. There is a rewriter for these files, with a config file at randomizerlauncheryamls.ini, which is a Windows-style ini file rather than a flat Unix one. Sections do matter when editing it. What's in the .ini file will overwrite whatever is in the yamls.You will almost certainly need to edit the rom_path entries in the ini file. I don't recommend editing the .yaml files directly as the .ini will overwrite them, but if you want to, comment out the sections in the ini. Also don't forget to edit host.yaml if you're doing this; the .ini file takes care of that quietly for you, currently.

Weird config note: for Zillion specifically, your ROM MUST be named as Zillion (UE) [!].sms . It can live in any directory, but the filename MUST match that exactly. This is inherited from Archipelago, which inherited it from zilliandomizer, so nothing I can do to change it unless I want to fix it in zilliandomizer, and that's likely beyond my scope... for now. No other randomizers currently have a restriction like this.

This is EARLY Beta at this point; it should progress as things go.

Supported randomizers currently:

(from akerasi https://github.com/akerasi/SJ-rando)

solarjetman (NES Solar Jetman)

(from Archipelago https://github.com/ArchipelagoMW/Archipelago)

alttp-a (SNES A Link To The Past)

dkc3-a (SNES Donkey Kong Country 3)

cv64-a (N64 Castlevania64)

kdl3-a (SNES Kirby's Dream Land 3)

loz-a (NES The Legend of Zelda)

l2-a (SNES Lufia 2 Ancient Caves)

mmbn3-a (GBA Mega Man Battle Network 3)

pokerb-a (GB Pokemon Red and Blue)

smz3-a (SNES Super Metroid and A Link to the Past Combo Randomizer)

soe-a (SNES Secret of Evermore)

sm-a (SNES Super Metroid)

yoshi-a (SNES Yoshi's Island)

yugioh06-a (GBA Yu Gi Oh Ultimate Master 2006)

zillion-a (SMS Zillion)

( From cleartonic: https://github.com/cleartonic/dq3hf )

dq3 (SNES Dragon Quest 3 Heavenly Flight (works with English patch or JP rom))

( From calm-palm: https://github.com/calm-palm/cotm-randomizer/ )

cotm (GBA Castlevania Circle of the Moon)

( From Osteoclave https://github.com/Osteoclave/actraiser-randomizer )

ar (SNES Actraiser)

sr (SNES Shadowrun)

(from Abyssonym)

bof3vv (PSX Breath of Fire 3 (Vast Violence))

ffl2 (GBA Final Fantasy Legend 2 (Mighty Power))

fft (PSX Final Fantasy Tactics)

(from wijnen)

mg (MSX Metal Gear)

(from Dinopony)

landstalker (Genesis Landstalker)

(from aerinon)

alttp-door (SNES A Link To The Past Door Randomizer) (BETA, does not allow option changing easily)

(from daid)

ladx (GBC Link's Awakening DX) (BETA does not allow option changing easily)

Version: 0.3.0
Author: akerasi (Allen Tipper)

CHANGELOG:
0.3.0: requirement removed: CS Degree. Now automatically builds your ini, detecting and finding ROMs you have, on first run. Takes a long time, but makes things Just Work. Also packaged for normal MiSTer updater scripts to download, and fixed a few bugs (used to have filepaths that'd make it not work, now tolerant of any filenames/paths).

0.2.2: The Great Archipelago Rename, and added many new randomizers that were easy to integrate. Also bugfixes.

0.2.1: Refactored such that a proper build system is in place for everything, and added a proper build system. Also cut out more of Archipelago that we don't need, so builds are much smaller.

0.1.6: Added Circle of the Moon https://github.com/calm-palm/cotm-randomizer/

0.1.5: Added Dragon Quest 3 Heavenly Flight https://github.com/cleartonic/dq3hf

0.1.4: Added autolaunch support, making cardlines easier to write, and added a working menu system for those without TapTo. Now works fine when launched from the MiSTer Scripts menu, and launches the rom when done building.

0.1.3: Added Zillion support, refactored directory structure so everything lives under one directory, randomizers, other than the main script and its two ini files.

0.1.2: Added YAML rewriter to handle Archipelago config YAMLs in a saner manner.

0.1.1: Initial release.

ACKNOWLEDGEMENTS

AnimeOt4ku for our logo, and quite possibly official templates for TapTo cards in the future.

The Archipelago project, https://github.com/ArchipelagoMW/Archipelago , from which we take many randomizers.

The TapTo Project, https://github.com/TapToCommunity/tapto , from which I was inspired to make this, and gave me an initial way to autolaunch roms. This project is much better utilized with TapTo than without, even though it works without it now.

MiSTer Batch Control, https://github.com/pocomane/MiSTer_Batch_Control , which we use to make autolaunch work.

The BIG List of Video Game Randomizers, https://randomizers.debigare.com/ , from which I've been sourcing most of the randomizers I've been considering for inclusion.

Niamek, for the original version of the Solar Jetman randomizer which I've forked and continued at https://github.com/akerasi/SJ-rando

cleartonic for the Dragon Quest 3 Heavenly Flight randomizer https://github.com/cleartonic/dq3hf

calm-palm for the Castlevania Cirlce of the Moon randomizer https://github.com/calm-palm/cotm-randomizer/

And last but not least, the MiSTer FPGA project: https://github.com/MiSTer-devel/Wiki_MiSTer/wiki
