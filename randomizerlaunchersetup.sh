#!/bin/bash
found_rom_path=""
rom_hash=""
rom_filename_pattern=""
rom_base_path="/tmp"
locate_rom(){
        readarray -t FIND_OUTPUT < <(find "$rom_base_path" -name "$rom_filename_pattern" -exec cksum {} \;)
        for line in "${FIND_OUTPUT[@]}"
        do
                echo "$line" | awk '{print $1'}
                if [ $(echo "$line" | awk '{print $1}') == $rom_hash ]; then
                        found_rom_path=$(echo "$line" | awk '{$1=$2=""; print $0}' | sed "s/^[ \t]*//" | sed -e "s/'/'\\\\''/g; 1s/^/'/; \$s/\$/'/")
                        echo "found $found_rom_path"
                        break;
                fi
        done
}
locate_rom_yaml(){
        readarray -t FIND_OUTPUT < <(find "$rom_base_path" -name "$rom_filename_pattern" -exec cksum {} \;)
        for line in "${FIND_OUTPUT[@]}"
        do
                echo "$line" | awk '{print $1'}
                if [ $(echo "$line" | awk '{print $1}') == $rom_hash ]; then
                        found_rom_path=$(echo "$line" | awk '{$1=$2=""; print $0}' | sed "s/^[ \t]*//")
                        echo "found $found_rom_path"
                        break;
                fi
        done	
}
mv randomizerlauncher.ini randomizerlauncher.ini.prev
mv randomizerlauncheryaml.ini randomizerlauncheryaml.ini.prev
echo "#Base DIRs and base setup" > randomizerlauncher.ini
BaseGameDir=$(randomizers/mbc list_rom_for NES | awk -F ' ' '{print $2}' | awk -F '/' 'sub(FS $NF,x)' | awk -F '/' 'sub(FS $NF,x)' | tail -1)
echo "BaseGameDir=$BaseGameDir" >> randomizerlauncher.ini
BaseNesDir=$(randomizers/mbc list_rom_for NES | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BaseNesDir=$BaseNesDir" >> randomizerlauncher.ini
BaseSnesDir=$(randomizers/mbc list_rom_for SNES | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}')
echo "BaseSnesDir=$BaseSnesDir" >> randomizerlauncher.ini
BaseGameboyDir=$(randomizers/mbc list_rom_for GAMEBOY | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BaseGameboyDir=$BaseGameboyDir" >> randomizerlauncher.ini
BaseGBADir=$(randomizers/mbc list_rom_for GBA | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BaseGBADir=$BaseGBADir" >> randomizerlauncher.ini
BaseN64Dir=$(randomizers/mbc list_rom_for N64 | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BaseN64Dir=$BaseN64Dir" >> randomizerlauncher.ini
BaseGenesisDir=$(randomizers/mbc list_rom_for MEGADRIVE | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
if [ "$BaseGenesisDir" == "" ]; then
		BaseGenesisDir=$(randomizers/mbc list_rom_for GENESIS | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
fi
if [ "$BaseGenesisDir" == "" ]; then
		BaseGenesisDir=$(randomizers/mbc list_rom_for GENESIS.BIN | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
fi
echo "BaseGenesisDir=$BaseGenesisDir" >> randomizerlauncher.ini
BaseSMSDir=$(randomizers/mbc list_rom_for SMS | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BaseSMSDir=$BaseSMSDir" >> randomizerlauncher.ini
BasePSXDir=$(randomizers/mbc list_rom_for PSX | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BasePSXDir=$BasePSXDir" >> randomizerlauncher.ini
BaseMSXDir=$(randomizers/mbc list_rom_for MSX | awk -F ' ' '{print $2}' | awk -F '/' '{print $(NF-1)}'| tail -1)
echo "BaseMSXDir=$BaseMSXDir" >> randomizerlauncher.ini
RandomizerBasedir=/media/fat/Scripts/randomizers
echo "BaseYamlDir=$RandomizerBasedir/yamls" >> randomizerlauncher.ini
echo "RandomizerBasedir=/media/fat/Scripts/randomizers" >> randomizerlauncher.ini
echo "TmpDir=$RandomizerBasedir/taptorandomizetmp" >> randomizerlauncher.ini
echo "ArchipelagoDir=$RandomizerBasedir/archipelago-0.5.0-MiSTerFPGA" >> randomizerlauncher.ini
echo "HostYamlPath=$RandomizerBaseDir/yamls/host.yaml" >> randomizerlauncher.ini
echo "SystemForAutolaunch=none" >> randomizerlauncher.ini
echo "KeepSeeds=5" >> randomizerlauncher.ini
echo "SolarJetmanRandoDir=SolarJetmanRando" >> randomizerlauncher.ini
rom_hash="4241161793"
rom_filename_pattern="*[Ss]olar*[Jj]etman*.nes"
rom_base_path="$BaseGameDir/$BaseNesDir/"
locate_rom
echo "SolarJetmanRom=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "SolarJetmanRandomizeAstronaut=0" >> randomizerlauncher.ini
echo "SolarJetmanRandomizePod=0" >> randomizerlauncher.ini
echo "SolarJetmanRandomizeItems=1" >> randomizerlauncher.ini
echo "SolarJetmanRandomizeItemsWithLogic=0" >> randomizerlauncher.ini
echo "SolarJetmanRandomizePallette=1" >> randomizerlauncher.ini
echo "SolarJetmanLateral=0" >> randomizerlauncher.ini
echo "SolarJetmanSeed=-1" >> randomizerlauncher.ini
echo "SolarJetmanMode=normal" >> randomizerlauncher.ini
echo "ALTTPRandoDir=ALTTPRando" >> randomizerlauncher.ini
echo "ALTTPPlayerDir=alttp" >> randomizerlauncher.ini
echo "DKC3RandoDir=DKC3Rando" >> randomizerlauncher.ini
echo "DKC3PlayerDir=dkc3" >> randomizerlauncher.ini
echo "CV64RandoDir=CV64Rando" >> randomizerlauncher.ini
echo "CV64PlayerDir=cv64" >> randomizerlauncher.ini
echo "KDL3RandoDir=KDL3Rando" >> randomizerlauncher.ini
echo "KDL3PlayerDir=kdl3" >> randomizerlauncher.ini
echo "LOZRandoDir=LOZRando" >> randomizerlauncher.ini
echo "LOZPlayerDir=loz" >> randomizerlauncher.ini
echo "L2RandoDir=L2Rando" >> randomizerlauncher.ini
echo "L2PlayerDir=lufia2" >> randomizerlauncher.ini
echo "MMBN3RandoDir=MMBN3Rando" >> randomizerlauncher.ini
echo "MMBN3PlayerDir=mmbn3" >> randomizerlauncher.ini
echo "#PokeERandoDir=PokemonEmeraldRando" >> randomizerlauncher.ini
echo "#PokeEPlayerDir=pokemonemerald" >> randomizerlauncher.ini
echo "#OOTRandoDir=OOTRando" >> randomizerlauncher.ini
echo "#OOTPlayerDir=oot" >> randomizerlauncher.ini
echo "PokeRBRandoDir=PokeRBRando" >> randomizerlauncher.ini
echo "PokeRBPlayerDir=pokemonrb" >> randomizerlauncher.ini
echo "SMWRandoDir=SMWRando" >> randomizerlauncher.ini
echo "SMWPlayerDir=smw" >> randomizerlauncher.ini
echo "SMZ3RandoDir=SMZ3Rando" >> randomizerlauncher.ini
echo "SMZ3PlayerDir=smz3" >> randomizerlauncher.ini
echo "SOERandoDir=SOERando" >> randomizerlauncher.ini
echo "SOEPlayerDir=soe" >> randomizerlauncher.ini
echo "BaseRandoDir=/tmp/rando/" >> randomizerlauncher.ini
echo "SMRandoDir=SMRando" >> randomizerlauncher.ini
echo "SMPlayerDir=supermetroid" >> randomizerlauncher.ini
echo "SMW2RandoDir=YIRando" >> randomizerlauncher.ini
echo "SMW2PlayerDir=yoshi" >> randomizerlauncher.ini
echo "YGORandoDir=YGORando" >> randomizerlauncher.ini
echo "YGOPlayerDir=yugioh" >> randomizerlauncher.ini
echo "DQ3RandoDir=DQ3Rando" >> randomizerlauncher.ini
rom_hash="2552947004"
rom_filename_pattern="*[Dd]ragon*[Qq]uest*[3iI]*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom
echo "DQ3RomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "ZillionRandoDir=ZillionRando" >> randomizerlauncher.ini
echo "ZillionPlayerDir=zillion" >> randomizerlauncher.ini
echo "COTMRandoDir=COTMRando" >> randomizerlauncher.ini
rom_hash="272442857"
rom_filename_pattern="*[Cc]ircle*[Oo]f*[Tt]he*[Mm]oon*.gba"
rom_base_path="$BaseGameDir/$BaseGBADir/"
locate_rom
echo "COTMRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "COTMignoreCleansing=0 " >> randomizerlauncher.ini
echo "COTMapplyAutoRunPatch=0 " >> randomizerlauncher.ini
echo "COTMapplyNoDSSGlitchPatch=0 " >> randomizerlauncher.ini
echo "COTMapplyAllowSpeedDash=0 " >> randomizerlauncher.ini
echo "COTMbreakIronMaidens=0 " >> randomizerlauncher.ini
echo "COTMlastKeyRequired=0 " >> randomizerlauncher.ini
echo "COTMlastKeyAvailable=0 " >> randomizerlauncher.ini
echo "COTMapplyBuffFamiliars=0 " >> randomizerlauncher.ini
echo "COTMapplyBuffSubweapons=0 " >> randomizerlauncher.ini
echo "COTMapplyShooterStrength=0 " >> randomizerlauncher.ini
echo "COTMdoNotRandomizeItems=0 " >> randomizerlauncher.ini
echo "COTMRandomItemHardMode=0 " >> randomizerlauncher.ini
echo "COTMhalveDSSCards=0 " >> randomizerlauncher.ini
echo "COTMcountdown=0 " >> randomizerlauncher.ini
echo "COTMsubweaponShuffle=0 " >> randomizerlauncher.ini
echo "COTMnoMPDrain=0 " >> randomizerlauncher.ini
echo "COTMallBossesRequired=0 " >> randomizerlauncher.ini
echo "COTMdssRunSpeed=1 " >> randomizerlauncher.ini
echo "COTMskipCutscenes=0 " >> randomizerlauncher.ini
echo "COTMskipMagicItemTutorials=0 " >> randomizerlauncher.ini
echo "COTMnerfRocWing=0" >> randomizerlauncher.ini
rom_hash="539543285"
rom_filename_pattern="*aiser*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom
echo "ARRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "ARRandoDir=ARRando" >> randomizerlauncher.ini
echo "ARExtraLives=0" >> randomizerlauncher.ini
echo "ARUnlimitedLives=0" >> randomizerlauncher.ini
echo "ARDeathCount=1" >> randomizerlauncher.ini
echo "ARSwordUpgrade=0" >> randomizerlauncher.ini
echo "ARMarhana='N'" >> randomizerlauncher.ini
echo "ARBossRush='C'" >> randomizerlauncher.ini
echo "BOF3Abilities=1" >> randomizerlauncher.ini
echo "BOF3Characters=1" >> randomizerlauncher.ini
echo "BOF3Enemies=0" >> randomizerlauncher.ini
echo "BOF3DragonLoc=0" >> randomizerlauncher.ini
echo "BOF3Masters=0" >> randomizerlauncher.ini
echo "BOF3Items=1" >> randomizerlauncher.ini
echo "BOF3Shops=1" >> randomizerlauncher.ini
echo "BOF3Treasure=1" >> randomizerlauncher.ini
echo "BOF3RandoDir=BOF3Rando" >> randomizerlauncher.ini
rom_hash="3141103799"
rom_filename_pattern="*[Bb]reath*[Oo]f*[Ff]ire*[3iI]*Track 1*.bin"
rom_base_path="$BaseGameDir/$BasePSXDir/"
locate_rom
echo "BOF3RomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "FFTAbilities=1" >> randomizerlauncher.ini
echo "FFTMusic=0" >> randomizerlauncher.ini
echo "FFTFormations=1" >> randomizerlauncher.ini
echo "FFTJobInnates=1" >> randomizerlauncher.ini
echo "FFTJobStats=1" >> randomizerlauncher.ini
echo "FFTShop=1" >> randomizerlauncher.ini
echo "FFTMaps=1" >> randomizerlauncher.ini
echo "FFTJobRequirements=1" >> randomizerlauncher.ini
echo "FTJobSkillsets=1" >> randomizerlauncher.ini
echo "FFTTrophies=1" >> randomizerlauncher.ini
echo "FFTUnits=1" >> randomizerlauncher.ini
echo "FFTWeapons=1" >> randomizerlauncher.ini
echo "FFTStatus=1" >> randomizerlauncher.ini
rom_hash="589112002"
rom_filename_pattern="*[Ff]inal*[Ff}antasy*[Tt]actics*.bin"
rom_base_path="$BaseGameDir/$BasePSXDir/"
locate_rom
echo "FFTRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "FFTRandoDir=FFTRando" >> randomizerlauncher.ini
rom_hash="3152808421"
rom_filename_pattern="*[Ff]inal*[Ff}antasy*[Ll]egend*[3iI].gb"
rom_base_path="$BaseGameDir/$BaseGameboyDir/"
locate_rom
echo "FFL2Evolutions=1" >> randomizerlauncher.ini
echo "FFL2Formations=1" >> randomizerlauncher.ini
echo "FFL2Items=1" >> randomizerlauncher.ini
echo "FFL2MonsterSkills=1" >> randomizerlauncher.ini
echo "FFL2MonsterStats=1" >> randomizerlauncher.ini
echo "FFL2MutantSkills=1" >> randomizerlauncher.ini
echo "FFL2Shops=1" >> randomizerlauncher.ini
echo "FFL2Treasure=1" >> randomizerlauncher.ini
echo "FFL2RomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "FFL2RandoDir=FFL2Rando" >> randomizerlauncher.ini
rom_hash="1985066866"
rom_filename_pattern="*[Mm]etal*[Gg]ear*"
rom_base_path="$BaseGameDir/$BaseMSXDir/"
locate_rom
echo "MGRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "MGRandoDir=MGRando" >> randomizerlauncher.ini
echo "LandstalkerRandoDir=LandstalkerRando" >> randomizerlauncher.ini
rom_hash="1709623910"
rom_filename_pattern="*[Ll]andstalker*"
rom_base_path="$BaseGameDir/$BaseGenesisDir/"
locate_rom
echo "LandstalkerRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "LandstalkerPreset='default.json'" >> randomizerlauncher.ini
rom_hash="1429148932"
rom_filename_pattern="*[Ss]hadowrun*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom
echo "ShadowrunRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "ShadowrunRandoDir=ShadowrunRando" >> randomizerlauncher.ini
echo "ALTTPDRandoDir=ALTTPDoorRando" >> randomizerlauncher.ini
rom_hash="1874204656"
rom_filename_pattern="*[Zz]elda*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom
echo "ALTTPDRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "LADXRandoDir=LADXRando" >> randomizerlauncher.ini
rom_hash="2667728101"
rom_filename_pattern="*[Zz]elda*.gbc"
rom_base_path="$BaseGameDir/$BaseGameboyDir/"
locate_rom
echo "LADXRomPath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "MegaManWeapons=1" >> randomizerlauncher.ini
echo "MegaManPalette=1" >> randomizerlauncher.ini
echo "MegaManWeakness=1" >> randomizerlauncher.ini
echo "MegaManBossDamage=1" >> randomizerlauncher.ini
echo "MegaManMusic=0" >> randomizerlauncher.ini
echo "MegaManRoll=1" >> randomizerlauncher.ini
rom_hash="3153316132"
rom_filename_pattern="*[Mm]ega*an*.nes"
rom_base_path="$BaseGameDir/$BaseNesDir/"
locate_rom
echo "MegaManRompath=$found_rom_path" >> randomizerlauncher.ini
found_rom_path=""
echo "MegaManRandoDir=MMRando" >> randomizerlauncher.ini
echo "[basedirs]" >> randomizerlauncheryaml.ini
echo "HostYamlPath=/media/fat/Scripts/randomizers/yamls/host.yaml" >> randomizerlauncheryaml.ini
echo "TmpDir=/media/fat/Scripts/randomizers/taptorandomizetmp/" >> randomizerlauncheryaml.ini
echo "" >> randomizerlauncheryaml.ini
echo "[alttp-a-yaml]" >> randomizerlauncheryaml.ini
echo "#ALTTP-Archipelago options to override the YAMLs options" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/alttp/MiSTerPlayerALTTP.yaml" >> randomizerlauncheryaml.ini
rom_hash="1874204656"
rom_filename_pattern="*[Zz]elda*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "goal=ganon" >> randomizerlauncheryaml.ini
echo "mode=open" >> randomizerlauncheryaml.ini
echo "glitches_required=no_glitches" >> randomizerlauncheryaml.ini
echo "dark_room_logic=lamp" >> randomizerlauncheryaml.ini
echo "open_pyramid=goal" >> randomizerlauncheryaml.ini
echo "crystals_needed_for_gt=6" >> randomizerlauncheryaml.ini
echo "crystals_needed_for_ganon=7" >> randomizerlauncheryaml.ini
echo "triforce_pieces_mode=available" >> randomizerlauncheryaml.ini
echo "triforce_pieces_percentage=150" >> randomizerlauncheryaml.ini
echo "triforce_pieces_required=20" >> randomizerlauncheryaml.ini
echo "triforce_pieces_available=30" >> randomizerlauncheryaml.ini
echo "triforce_pieces_extra=10" >> randomizerlauncheryaml.ini
echo "entrance_shuffle=vanilla" >> randomizerlauncheryaml.ini
echo "entrance_shuffle_seed=random" >> randomizerlauncheryaml.ini
echo "big_key_shuffle=original_dungeon" >> randomizerlauncheryaml.ini
echo "small_key_shuffle=original_dungeon" >> randomizerlauncheryaml.ini
echo "key_drop_shuffle=true" >> randomizerlauncheryaml.ini
echo "compass_shuffle=original_dungeon" >> randomizerlauncheryaml.ini
echo "map_shuffle=original_dungeon" >> randomizerlauncheryaml.ini
echo "restrict_dungeon_item_on_boss=false" >> randomizerlauncheryaml.ini
echo "item_pool=normal" >> randomizerlauncheryaml.ini
echo "item_functionality=normal" >> randomizerlauncheryaml.ini
echo "enemy_health=default" >> randomizerlauncheryaml.ini
echo "enemy_damage=default" >> randomizerlauncheryaml.ini
echo "progressive=on" >> randomizerlauncheryaml.ini
echo "swordless=false" >> randomizerlauncheryaml.ini
echo "dungeon_counters=pickup" >> randomizerlauncheryaml.ini
echo "retro_bow=false" >> randomizerlauncheryaml.ini
echo "retro_caves=false" >> randomizerlauncheryaml.ini
echo "hints=on" >> randomizerlauncheryaml.ini
echo "scams=off" >> randomizerlauncheryaml.ini
echo "boss_shuffle=none" >> randomizerlauncheryaml.ini
echo "pot_shuffle=false" >> randomizerlauncheryaml.ini
echo "enemy_shuffle=false" >> randomizerlauncheryaml.ini
echo "killable_thieves=false" >> randomizerlauncheryaml.ini
echo "bush_shuffle=false" >> randomizerlauncheryaml.ini
echo "shop_item_slots=0" >> randomizerlauncheryaml.ini
echo "randomize_shop_inventories=default" >> randomizerlauncheryaml.ini
echo "shuffle_shop_inventories=false" >> randomizerlauncheryaml.ini
echo "include_witch_hut=false" >> randomizerlauncheryaml.ini
echo "randomize_shop_prices=false" >> randomizerlauncheryaml.ini
echo "randomize_cost_types=false" >> randomizerlauncheryaml.ini
echo "shop_price_modifier=100" >> randomizerlauncheryaml.ini
echo "shuffle_capacity_upgrades=off" >> randomizerlauncheryaml.ini
echo "bombless_start=false" >> randomizerlauncheryaml.ini
echo "shuffle_prizes=general" >> randomizerlauncheryaml.ini
echo "tile_shuffle=false" >> randomizerlauncheryaml.ini
echo "glitch_boots=true" >> randomizerlauncheryaml.ini
echo "beemizer_total_chance=0" >> randomizerlauncheryaml.ini
echo "beemizer_trap_chance=60" >> randomizerlauncheryaml.ini
echo "timer=none" >> randomizerlauncheryaml.ini
echo "countdown_start_time=10" >> randomizerlauncheryaml.ini
echo "red_clock_time=-2" >> randomizerlauncheryaml.ini
echo "blue_clock_time=2" >> randomizerlauncheryaml.ini
echo "green_clock_time=4" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "allow_collect=true" >> randomizerlauncheryaml.ini
echo "ow_palettes=default" >> randomizerlauncheryaml.ini
echo "uw_palettes=default" >> randomizerlauncheryaml.ini
echo "hud_palettes=default" >> randomizerlauncheryaml.ini
echo "sword_palettes=default" >> randomizerlauncheryaml.ini
echo "shield_palettes=default" >> randomizerlauncheryaml.ini
echo "heartbeep=normal" >> randomizerlauncheryaml.ini
echo "heartcolor=red" >> randomizerlauncheryaml.ini
echo "quickswap=true" >> randomizerlauncheryaml.ini
echo "menuspeed=normal" >> randomizerlauncheryaml.ini
echo "music=true" >> randomizerlauncheryaml.ini
echo "reduceflashing=true" >> randomizerlauncheryaml.ini
echo "triforcehud=normal" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
echo "start_inventory_from_pool=null" >> randomizerlauncheryaml.ini
echo "misery_mire_medallion=random" >> randomizerlauncheryaml.ini
echo "turtle_rock_medallion=random" >> randomizerlauncheryaml.ini
echo "" >> randomizerlauncheryaml.ini
echo "[dkc3-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/dkc3/MiSTerPlayerDKC3.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "dk_coins_for_gyrocopter=30" >> randomizerlauncheryaml.ini
echo "kongsanity=false" >> randomizerlauncheryaml.ini
echo "level_shuffle=false" >> randomizerlauncheryaml.ini
echo "difficulty=norml" >> randomizerlauncheryaml.ini
echo "goal=knautilus" >> randomizerlauncheryaml.ini
echo "krematoa_bonus_coin_cost=15" >> randomizerlauncheryaml.ini
echo "percentage_of_extra_bonus_coins=100" >> randomizerlauncheryaml.ini
echo "number_of_banana_birds=15" >> randomizerlauncheryaml.ini
echo "percentage_of_banana_birds=100" >> randomizerlauncheryaml.ini
echo "autosave=true" >> randomizerlauncheryaml.ini
echo "merry=false" >> randomizerlauncheryaml.ini
echo "music_shuffle=false" >> randomizerlauncheryaml.ini
echo "kong_palette_swap=default" >> randomizerlauncheryaml.ini
echo "starting_life_count=5" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="794245588"
rom_filename_pattern="*[Dd]onkey*[Kk]ong*[Cc]ountry*[3iI]*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[cv64-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/cv64/MiSTerPlayerCV64.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "character_stages=both" >> randomizerlauncheryaml.ini
echo "stage_shuffle=false" >> randomizerlauncheryaml.ini
echo "warp_order=seed_stage_order" >> randomizerlauncheryaml.ini
echo "sub_weapon_shuffle=off" >> randomizerlauncheryaml.ini
echo "spare_keys=off" >> randomizerlauncheryaml.ini
echo "special1s_per_warp=1" >> randomizerlauncheryaml.ini
echo "total_special1s=7" >> randomizerlauncheryaml.ini
echo "draculas_condition=crystal" >> randomizerlauncheryaml.ini
echo "percent_special2s_required=80" >> randomizerlauncheryaml.ini
echo "total_special2s=25" >> randomizerlauncheryaml.ini
echo "bosses_required=12" >> randomizerlauncheryaml.ini
echo "carrie_logic=false" >> randomizerlauncheryaml.ini
echo "hard_logic=false" >> randomizerlauncheryaml.ini
echo "multi_hit_breakables=false" >> randomizerlauncheryaml.ini
echo "empty_breakables=false" >> randomizerlauncheryaml.ini
echo "lizard_locker_items=false" >> randomizerlauncheryaml.ini
echo "shopsanity=false" >> randomizerlauncheryaml.ini
echo "hard_item_pool=false" >> randomizerlauncheryaml.ini
echo "shop_prices=vanilla" >> randomizerlauncheryaml.ini
echo "minimum_gold_price=2" >> randomizerlauncheryaml.ini
echo "maximum_gold_price=30" >> randomizerlauncheryaml.ini
echo "post_behemoth_boss=vanilla" >> randomizerlauncheryaml.ini
echo "room_of_clocks_boss=vanilla" >> randomizerlauncheryaml.ini
echo "renon_fight_condition=spend_30k" >> randomizerlauncheryaml.ini
echo "vincent_fight_condition=wait_16_days" >> randomizerlauncheryaml.ini
echo "bad_ending_condition=kill_vincent" >> randomizerlauncheryaml.ini
echo "increase_item_limit=true" >> randomizerlauncheryaml.ini
echo "nerf_healing_items=false" >> randomizerlauncheryaml.ini
echo "loading_zone_heals=true" >> randomizerlauncheryaml.ini
echo "invisible_items=vanilla" >> randomizerlauncheryaml.ini
echo "drop_previous_sub_weapon=false" >> randomizerlauncheryaml.ini
echo "permanent_powerups=false" >> randomizerlauncheryaml.ini
echo "ice_trap_percentage=0" >> randomizerlauncheryaml.ini
echo "ice_trap_appearance=major_only" >> randomizerlauncheryaml.ini
echo "disable_time_restrictions=false" >> randomizerlauncheryaml.ini
echo "skip_gondolas=false" >> randomizerlauncheryaml.ini
echo "skip_waterway_blocks=false" >> randomizerlauncheryaml.ini
echo "countdown=none" >> randomizerlauncheryaml.ini
echo "big_toss=false" >> randomizerlauncheryaml.ini
echo "panther_dash=off" >> randomizerlauncheryaml.ini
echo "increase_shimmy_speed=false" >> randomizerlauncheryaml.ini
echo "fall_guard=false" >> randomizerlauncheryaml.ini
echo "death_link=off" >> randomizerlauncheryaml.ini
echo "window_color_r=1" >> randomizerlauncheryaml.ini
echo "window_color_g=5" >> randomizerlauncheryaml.ini
echo "window_color_b=15" >> randomizerlauncheryaml.ini
echo "window_color_a=8" >> randomizerlauncheryaml.ini
echo "background_music=normal" >> randomizerlauncheryaml.ini
echo "map_lighting=normal" >> randomizerlauncheryaml.ini
echo "cinematic_experience=false" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
echo "start_inventory_from_pool=null" >> randomizerlauncheryaml.ini
echo "starting_stage=random" >> randomizerlauncheryaml.ini
rom_hash="4007411395"
rom_filename_pattern="*[Cc]astlevania*.[zn]64"
rom_base_path="$BaseGameDir/$BaseN64Dir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[kdl3-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/kdl3/MiSTerPlayerKDL3.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "game_language=english" >> randomizerlauncheryaml.ini
echo "goal=zero" >> randomizerlauncheryaml.ini
echo "goal_speed=normal" >> randomizerlauncheryaml.ini
echo "total_heart_stars=30" >> randomizerlauncheryaml.ini
echo "heart_stars_required=50" >> randomizerlauncheryaml.ini
echo "filler_percentage=50" >> randomizerlauncheryaml.ini
echo "trap_percentage=50" >> randomizerlauncheryaml.ini
echo "gooey_trap_weight=50" >> randomizerlauncheryaml.ini
echo "slow_trap_weight=50" >> randomizerlauncheryaml.ini
echo "ability_trap_weight=50" >> randomizerlauncheryaml.ini
echo "jumping_target=10" >> randomizerlauncheryaml.ini
echo "stage_shuffle=none" >> randomizerlauncheryaml.ini
echo "boss_shuffle=none" >> randomizerlauncheryaml.ini
echo "allow_bb=disabled" >> randomizerlauncheryaml.ini
echo "animal_randomization=disabled" >> randomizerlauncheryaml.ini
echo "copy_ability_randomization=disabled" >> randomizerlauncheryaml.ini
echo "strict_bosses=true" >> randomizerlauncheryaml.ini
echo "open_world=true" >> randomizerlauncheryaml.ini
echo "ow_boss_requirement=3" >> randomizerlauncheryaml.ini
echo "boss_requirement_random=false" >> randomizerlauncheryaml.ini
echo "consumables=false" >> randomizerlauncheryaml.ini
echo "starsanity=false" >> randomizerlauncheryaml.ini
echo "gifting=false" >> randomizerlauncheryaml.ini
echo "kirby_flavor_preset=default" >> randomizerlauncheryaml.ini
echo "gooey_flavor_preset=default" >> randomizerlauncheryaml.ini
echo "music_shuffle=none" >> randomizerlauncheryaml.ini
echo "virtual_console=flash_reduction" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="11650140"
rom_filename_pattern="*[Kk]irby*[Dd]ream*[Ll]and*[3iI]*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[loz-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/loz/MiSTerPlayerLegendOfZelda.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "ExpandedPool=true" >> randomizerlauncheryaml.ini
echo "TriforceLocations=vanilla" >> randomizerlauncheryaml.ini
echo "StartingPosition=safe  start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="2049839771"
rom_filename_pattern="*[Ll]egend*[Oo]f*[Zz]elda*.nes"
rom_base_path="$BaseGameDir/$BaseNesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[l2ac-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/lufia2/MiSTerPlayerLufia2.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "blue_chest_chance=25" >> randomizerlauncheryaml.ini
echo "blue_chest_count=25" >> randomizerlauncheryaml.ini
echo "boss=master" >> randomizerlauncheryaml.ini
echo "capsule_cravings_jp_style=false" >> randomizerlauncheryaml.ini
echo "capsule_starting_form=1" >> randomizerlauncheryaml.ini
echo "capsule_starting_level=1" >> randomizerlauncheryaml.ini
echo "crowded_floor_chance=16" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "default_capsule=jelze" >> randomizerlauncheryaml.ini
echo "default_party=m" >> randomizerlauncheryaml.ini
echo "enemy_floor_numbers=vanilla" >> randomizerlauncheryaml.ini
echo "enemy_movement_patterns=vanilla" >> randomizerlauncheryaml.ini
echo "enemy_sprites=vanilla" >> randomizerlauncheryaml.ini
echo "exp_modifier=100" >> randomizerlauncheryaml.ini
echo "final_floor=99" >> randomizerlauncheryaml.ini
echo "gear_variety_after_b9=false" >> randomizerlauncheryaml.ini
echo "goal=boss" >> randomizerlauncheryaml.ini
echo "gold_modifier=100" >> randomizerlauncheryaml.ini
echo "healing_floor_chance=16" >> randomizerlauncheryaml.ini
echo "inactive_exp_gain=disabled" >> randomizerlauncheryaml.ini
echo "initial_floor=1" >> randomizerlauncheryaml.ini
echo "iris_floor_chance=5" >> randomizerlauncheryaml.ini
echo "iris_treasures_required=9" >> randomizerlauncheryaml.ini
echo "master_hp=9980" >> randomizerlauncheryaml.ini
echo "party_starting_level=1" >> randomizerlauncheryaml.ini
echo "run_speed=disabled" >> randomizerlauncheryaml.ini
echo "shop_interval=1" >> randomizerlauncheryaml.ini
echo "shuffle_capsule_monsters=false" >> randomizerlauncheryaml.ini
echo "shuffle_party_members=false" >> randomizerlauncheryaml.ini
echo "custom_item_pool=null" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="2577076769"
rom_filename_pattern="*[Ll]ufia*[2iI]*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[mmbn3-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/mmbn3/MiSTerPlayerMMBN3.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "extra_ranks=0" >> randomizerlauncheryaml.ini
echo "include_jobs=true" >> randomizerlauncheryaml.ini
echo "trade_quest_hinting=full" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="1642717786"
rom_filename_pattern="*[Mm]ega*[Mm]an*[Bb]attle*[Nn]etwork*[3iI]*.gba"
rom_base_path="$BaseGameDir/$BaseGBADir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[pokerb-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/pokemonrb/MiSTerPlayerPokemonRB.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "rainer_name=choose_in_game" >> randomizerlauncheryaml.ini
echo "rival_name=choose_in_game" >> randomizerlauncheryaml.ini
echo "elite_four_badges_condition=8" >> randomizerlauncheryaml.ini
echo "elite_four_key_items_condition=0" >> randomizerlauncheryaml.ini
echo "elite_four_pokedex_condition=0" >> randomizerlauncheryaml.ini
echo "victory_road_condition=7" >> randomizerlauncheryaml.ini
echo "route_22_gate_condition=7" >> randomizerlauncheryaml.ini
echo "viridian_gym_condition=7" >> randomizerlauncheryaml.ini
echo "cerulean_cave_badges_condition=4" >> randomizerlauncheryaml.ini
echo "cerulean_cave_key_items_condition=50" >> randomizerlauncheryaml.ini
echo "route_3_condition=defeat_brock" >> randomizerlauncheryaml.ini
echo "robbed_house_officer=true" >> randomizerlauncheryaml.ini
echo "second_fossil_check_condition=3" >> randomizerlauncheryaml.ini
echo "fossil_check_item_types=any" >> randomizerlauncheryaml.ini
echo "exp_all=randomize" >> randomizerlauncheryaml.ini
echo "old_man=early_parcel" >> randomizerlauncheryaml.ini
echo "badgesanity=false" >> randomizerlauncheryaml.ini
echo "badges_needed_for_hm_moves=on" >> randomizerlauncheryaml.ini
echo "key_items_only=false" >> randomizerlauncheryaml.ini
echo "tea=false" >> randomizerlauncheryaml.ini
echo "extra_key_items=false" >> randomizerlauncheryaml.ini
echo "split_card_key=off" >> randomizerlauncheryaml.ini
echo "all_elevators_locked=true" >> randomizerlauncheryaml.ini
echo "extra_strength_boulders=false" >> randomizerlauncheryaml.ini
echo "require_item_finder=false" >> randomizerlauncheryaml.ini
echo "randomize_hidden_items=off" >> randomizerlauncheryaml.ini
echo "prizesanity=false" >> randomizerlauncheryaml.ini
echo "trainersanity=false" >> randomizerlauncheryaml.ini
echo "dexsanity=0" >> randomizerlauncheryaml.ini
echo "randomize_pokedex=vanilla" >> randomizerlauncheryaml.ini
echo "require_pokedex=true" >> randomizerlauncheryaml.ini
echo "all_pokemon_seen=false" >> randomizerlauncheryaml.ini
echo "oaks_aide_rt_2=10" >> randomizerlauncheryaml.ini
echo "oaks_aide_rt_11=20" >> randomizerlauncheryaml.ini
echo "oaks_aide_rt_15=30" >> randomizerlauncheryaml.ini
echo "stonesanity=false" >> randomizerlauncheryaml.ini
echo "door_shuffle=off" >> randomizerlauncheryaml.ini
echo "warp_tile_shuffle=vanilla" >> randomizerlauncheryaml.ini
echo "randomize_rock_tunnel=false" >> randomizerlauncheryaml.ini
echo "dark_rock_tunnel_logic=true" >> randomizerlauncheryaml.ini
echo "free_fly_location=true" >> randomizerlauncheryaml.ini
echo "town_map_fly_location=false" >> randomizerlauncheryaml.ini
echo "blind_trainers=0" >> randomizerlauncheryaml.ini
echo "minimum_steps_between_encounters=3" >> randomizerlauncheryaml.ini
echo "level_scaling=auto" >> randomizerlauncheryaml.ini
echo "exp_modifier=16" >> randomizerlauncheryaml.ini
echo "randomize_wild_pokemon=vanilla" >> randomizerlauncheryaml.ini
echo "area_1_to_1_mapping=true" >> randomizerlauncheryaml.ini
echo "randomize_starter_pokemon=vanilla" >> randomizerlauncheryaml.ini
echo "randomize_static_pokemon=vanilla" >> randomizerlauncheryaml.ini
echo "randomize_legendary_pokemon=vanilla" >> randomizerlauncheryaml.ini
echo "catch_em_all=off" >> randomizerlauncheryaml.ini
echo "randomize_pokemon_stats=vanilla" >> randomizerlauncheryaml.ini
echo "randomize_pokemon_catch_rates=false" >> randomizerlauncheryaml.ini
echo "minimum_catch_rate=3" >> randomizerlauncheryaml.ini
echo "randomize_trainer_parties=vanilla" >> randomizerlauncheryaml.ini
echo "trainer_legendaries=false" >> randomizerlauncheryaml.ini
echo "move_balancing=false" >> randomizerlauncheryaml.ini
echo "fix_combat_bugs=true" >> randomizerlauncheryaml.ini
echo "randomize_pokemon_movesets=vanilla" >> randomizerlauncheryaml.ini
echo "confine_transform_to_ditto=true" >> randomizerlauncheryaml.ini
echo "start_with_four_moves=false" >> randomizerlauncheryaml.ini
echo "same_type_attack_bonus=true" >> randomizerlauncheryaml.ini
echo "randomize_tm_moves=false" >> randomizerlauncheryaml.ini
echo "tm_same_type_compatibility=0" >> randomizerlauncheryaml.ini
echo "tm_normal_type_compatibility=0" >> randomizerlauncheryaml.ini
echo "tm_other_type_compatibility=0" >> randomizerlauncheryaml.ini
echo "hm_same_type_compatibility=0" >> randomizerlauncheryaml.ini
echo "hm_normal_type_compatibility=0" >> randomizerlauncheryaml.ini
echo "hm_other_type_compatibility=0" >> randomizerlauncheryaml.ini
echo "inherit_tm_hm_compatibility=false" >> randomizerlauncheryaml.ini
echo "randomize_move_types=false" >> randomizerlauncheryaml.ini
echo "randomize_pokemon_types=vanilla" >> randomizerlauncheryaml.ini
echo "secondary_type_chance=0" >> randomizerlauncheryaml.ini
echo "randomize_type_chart=vanilla" >> randomizerlauncheryaml.ini
echo "normal_matchups=143" >> randomizerlauncheryaml.ini
echo "super_effective_matchups=38" >> randomizerlauncheryaml.ini
echo "not_very_effective_matchups=38" >> randomizerlauncheryaml.ini
echo "immunity_matchups=6" >> randomizerlauncheryaml.ini
echo "safari_zone_normal_battles=false" >> randomizerlauncheryaml.ini
echo "normalize_encounter_chances=false" >> randomizerlauncheryaml.ini
echo "reusable_tms=false" >> randomizerlauncheryaml.ini
echo "better_shops=off" >> randomizerlauncheryaml.ini
echo "master_ball_price=5000" >> randomizerlauncheryaml.ini
echo "starting_money=3000" >> randomizerlauncheryaml.ini
echo "lose_money_on_blackout=true" >> randomizerlauncheryaml.ini
echo "poke_doll_skip=patched" >> randomizerlauncheryaml.ini
echo "bicycle_gate_skips=patched" >> randomizerlauncheryaml.ini
echo "trap_percentage=0" >> randomizerlauncheryaml.ini
echo "poison_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "fire_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "paralyze_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "sleep_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "ice_trap_weight=disabled" >> randomizerlauncheryaml.ini
echo "randomize_pokemon_palettes=vanilla" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
echo "game_version=random" >> randomizerlauncheryaml.ini
rom_hash="71714191"
rom_filename_pattern="*[Pp]ok*mon*[Rr]ed*.gb"
rom_base_path="$BaseGameDir/$BaseGameboyDir/"
locate_rom_yaml
echo "red_rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
rom_hash="847383023"
rom_filename_pattern="*[Pp]ok*mon*[Bb]lue*.gb"
rom_base_path="$BaseGameDir/$BaseGameboyDir/"
locate_rom_yaml
echo "blue_rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[smw-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/smw/MiSTerPlayerSMW.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "early_climb=false" >> randomizerlauncheryaml.ini
echo "goal=bowser" >> randomizerlauncheryaml.ini
echo "bosses_required=7" >> randomizerlauncheryaml.ini
echo "max_yoshi_egg_cap=50" >> randomizerlauncheryaml.ini
echo "percentage_of_yoshi_eggs=100" >> randomizerlauncheryaml.ini
echo "dragon_coin_checks=false" >> randomizerlauncheryaml.ini
echo "moon_checks=false" >> randomizerlauncheryaml.ini
echo "hidden_1up_checks=false" >> randomizerlauncheryaml.ini
echo "bonus_block_checks=false" >> randomizerlauncheryaml.ini
echo "blocksanity=false" >> randomizerlauncheryaml.ini
echo "bowser_castle_doors=vanilla" >> randomizerlauncheryaml.ini
echo "bowser_castle_rooms=random_two_room" >> randomizerlauncheryaml.ini
echo "level_shuffle=false" >> randomizerlauncheryaml.ini
echo "exclude_special_zone=false" >> randomizerlauncheryaml.ini
echo "boss_shuffle=none" >> randomizerlauncheryaml.ini
echo "swap_donut_gh_exits=false" >> randomizerlauncheryaml.ini
echo "junk_fill_percentage=0" >> randomizerlauncheryaml.ini
echo "trap_fill_percentage=0" >> randomizerlauncheryaml.ini
echo "ice_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "stun_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "literature_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "timer_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "reverse_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "thwimp_trap_weight=medium" >> randomizerlauncheryaml.ini
echo "display_received_item_popups=progression_minus_yoshi_eggs" >> randomizerlauncheryaml.ini
echo "autosave=true" >> randomizerlauncheryaml.ini
echo "overworld_speed=vanilla" >> randomizerlauncheryaml.ini
echo "music_shuffle=none" >> randomizerlauncheryaml.ini
echo "sfx_shuffle=none" >> randomizerlauncheryaml.ini
echo "mario_palette=mario" >> randomizerlauncheryaml.ini
echo "level_palette_shuffle=off" >> randomizerlauncheryaml.ini
echo "overworld_palette_shuffle=off" >> randomizerlauncheryaml.ini
echo "starting_life_count=5" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="335251469"
rom_filename_pattern="*[Ss]uper*[Mm]ario*[Ww]orld*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[smz3-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/smz3/MiSTerPlayerSMZ3.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "sm_logic=normal" >> randomizerlauncheryaml.ini
echo "sword_location=randomized" >> randomizerlauncheryaml.ini
echo "morph_location=randomized" >> randomizerlauncheryaml.ini
echo "goal=defeatboth" >> randomizerlauncheryaml.ini
echo "key_shuffle=none" >> randomizerlauncheryaml.ini
echo "open_tower=7" >> randomizerlauncheryaml.ini
echo "ganon_vulnerable=7" >> randomizerlauncheryaml.ini
echo "open_tourian=4" >> randomizerlauncheryaml.ini
echo "spin_jumps_animation=false" >> randomizerlauncheryaml.ini
echo "heart_beep_speed=normal" >> randomizerlauncheryaml.ini
echo "heart_color=red" >> randomizerlauncheryaml.ini
echo "quick_swap=false" >> randomizerlauncheryaml.ini
echo "energy_beep=true" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="1920880510"
rom_filename_pattern="*[Ss]uper*[Mm]etroid*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml 
echo "sm_rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
rom_hash="1874204656"
rom_filename_pattern="*[Zz]elda*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "z3_rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[soe-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/soe/MiSTerPlayerSoE.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=30" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "difficulty=normal" >> randomizerlauncheryaml.ini
echo "energy_core=shuffle" >> randomizerlauncheryaml.ini
echo "required_fragments=10" >> randomizerlauncheryaml.ini
echo "available_fragments=11" >> randomizerlauncheryaml.ini
echo "money_modifier=200" >> randomizerlauncheryaml.ini
echo "exp_modifier=200" >> randomizerlauncheryaml.ini
echo "sequence_breaks=off" >> randomizerlauncheryaml.ini
echo "out_of_bounds=off" >> randomizerlauncheryaml.ini
echo "fix_cheats=true" >> randomizerlauncheryaml.ini
echo "fix_infinite_ammo=false" >> randomizerlauncheryaml.ini
echo "fix_atlas_glitch=false" >> randomizerlauncheryaml.ini
echo "fix_wings_glitch=false" >> randomizerlauncheryaml.ini
echo "shorter_dialogs=true" >> randomizerlauncheryaml.ini
echo "short_boss_rush=true" >> randomizerlauncheryaml.ini
echo "ingredienizer=on" >> randomizerlauncheryaml.ini
echo "sniffamizer=shuffle" >> randomizerlauncheryaml.ini
echo "sniff_ingredients=vanilla_ingredients" >> randomizerlauncheryaml.ini
echo "callbeadamizer=on" >> randomizerlauncheryaml.ini
echo "musicmizer=false" >> randomizerlauncheryaml.ini
echo "doggomizer=off" >> randomizerlauncheryaml.ini
echo "turdo_mode=false" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "trap_count=0" >> randomizerlauncheryaml.ini
echo "trap_chance_quake=20" >> randomizerlauncheryaml.ini
echo "trap_chance_poison=20" >> randomizerlauncheryaml.ini
echo "trap_chance_confound=20" >> randomizerlauncheryaml.ini
echo "trap_chance_hud=20" >> randomizerlauncheryaml.ini
echo "trap_chance_ohko=20" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="836922997"
rom_filename_pattern="*[Ss]ecret*[Oo]f*[Ee]vermore*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini

echo "[sm-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/supermetroid/MiSTerPlayerSuperMetroid.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "start_inventory_removes_from_pool=false" >> randomizerlauncheryaml.ini
echo "preset=regular" >> randomizerlauncheryaml.ini
echo "start_location=landing_site" >> randomizerlauncheryaml.ini
echo "remote_items=false" >> randomizerlauncheryaml.ini
echo "death_link=disable" >> randomizerlauncheryaml.ini
echo "max_difficulty=hardcore" >> randomizerlauncheryaml.ini
echo "morph_placement=early" >> randomizerlauncheryaml.ini
echo "hide_items=false" >> randomizerlauncheryaml.ini
echo "strict_minors=false" >> randomizerlauncheryaml.ini
echo "missile_qty=30" >> randomizerlauncheryaml.ini
echo "super_qty=20" >> randomizerlauncheryaml.ini
echo "power_bomb_qty=10" >> randomizerlauncheryaml.ini
echo "minor_qty=100" >> randomizerlauncheryaml.ini
echo "energy_qty=vanilla" >> randomizerlauncheryaml.ini
echo "area_randomization=off" >> randomizerlauncheryaml.ini
echo "area_layout=false" >> randomizerlauncheryaml.ini
echo "doors_colors_rando=false" >> randomizerlauncheryaml.ini
echo "allow_grey_doors=false" >> randomizerlauncheryaml.ini
echo "boss_randomization=false" >> randomizerlauncheryaml.ini
echo "escape_rando=false" >> randomizerlauncheryaml.ini
echo "remove_escape_enemies=false" >> randomizerlauncheryaml.ini
echo "fun_combat=false" >> randomizerlauncheryaml.ini
echo "fun_movement=false" >> randomizerlauncheryaml.ini
echo "fun_suits=false" >> randomizerlauncheryaml.ini
echo "layout_patches=true" >> randomizerlauncheryaml.ini
echo "varia_tweaks=false" >> randomizerlauncheryaml.ini
echo "nerfed_charge=false" >> randomizerlauncheryaml.ini
echo "gravity_behaviour=balanced" >> randomizerlauncheryaml.ini
echo "elevators_speed=true" >> randomizerlauncheryaml.ini
echo "fast_doors=true" >> randomizerlauncheryaml.ini
echo "spin_jump_restart=false" >> randomizerlauncheryaml.ini
echo "rando_speed=false" >> randomizerlauncheryaml.ini
echo "infinite_space_jump=false" >> randomizerlauncheryaml.ini
echo "refill_before_save=false" >> randomizerlauncheryaml.ini
echo "hud=false" >> randomizerlauncheryaml.ini
echo "animals=false" >> randomizerlauncheryaml.ini
echo "no_music=false" >> randomizerlauncheryaml.ini
echo "random_music=false" >> randomizerlauncheryaml.ini
echo "tourian=vanilla" >> randomizerlauncheryaml.ini
echo "custom_objective=false" >> randomizerlauncheryaml.ini
echo "custom_objective_list=random" >> randomizerlauncheryaml.ini
echo "custom_objective_count=4" >> randomizerlauncheryaml.ini
echo "objective=kill all G4" >> randomizerlauncheryaml.ini
echo "relaxed_round_robin_cf=false" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="1920880510"
rom_filename_pattern="*[Ss]uper*[Mm]etroid*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml 
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[smw2-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/yoshi/MiSTerPlayerYoshi.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "starting_world=world_1" >> randomizerlauncheryaml.ini
echo "starting_lives=3" >> randomizerlauncheryaml.ini
echo "goal=bowser" >> randomizerlauncheryaml.ini
echo "luigi_pieces_required=25" >> randomizerlauncheryaml.ini
echo "luigi_pieces_in_pool=50" >> randomizerlauncheryaml.ini
echo "extras_enabled=false" >> randomizerlauncheryaml.ini
echo "minigame_checks=none" >> randomizerlauncheryaml.ini
echo "split_extras=false" >> randomizerlauncheryaml.ini
echo "split_bonus=false" >> randomizerlauncheryaml.ini
echo "hidden_object_visibility=coins_only" >> randomizerlauncheryaml.ini
echo "add_secretlens=false" >> randomizerlauncheryaml.ini
echo "shuffle_midrings=false" >> randomizerlauncheryaml.ini
echo "stage_logic=strict" >> randomizerlauncheryaml.ini
echo "item_logic=false" >> randomizerlauncheryaml.ini
echo "disable_autoscroll=false" >> randomizerlauncheryaml.ini
echo "softlock_prevention=true" >> randomizerlauncheryaml.ini
echo "castle_open_condition=5" >> randomizerlauncheryaml.ini
echo "castle_clear_condition=0" >> randomizerlauncheryaml.ini
echo "bowser_door_mode=manual" >> randomizerlauncheryaml.ini
echo "level_shuffle=disabled" >> randomizerlauncheryaml.ini
echo "boss_shuffle=false" >> randomizerlauncheryaml.ini
echo "yoshi_colors=normal" >> randomizerlauncheryaml.ini
echo "yoshi_singularity_color=green" >> randomizerlauncheryaml.ini
echo "baby_mario_sound=normal" >> randomizerlauncheryaml.ini
echo "traps_enabled=false" >> randomizerlauncheryaml.ini
echo "trap_percent=10" >> randomizerlauncheryaml.ini
echo "death_link=false" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="596817688"
rom_filename_pattern="*[Ss]uper*[Mm]ario*[Ww]orld*[2iI]*.s[mf]c"
rom_base_path="$BaseGameDir/$BaseSnesDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[ygo-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/yugioh/MiSTerPlayerYuGiOh.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "structure_deck=random_deck" >> randomizerlauncheryaml.ini
echo "banlist=september_2005" >> randomizerlauncheryaml.ini
echo "final_campaign_boss_unlock_condition=campaign_opponents" >> randomizerlauncheryaml.ini
echo "fourth_tier_5_campaign_boss_unlock_condition=campaign_opponents" >> randomizerlauncheryaml.ini
echo "third_tier_5_campaign_boss_unlock_condition=campaign_opponents" >> randomizerlauncheryaml.ini
echo "final_campaign_boss_challenges=10" >> randomizerlauncheryaml.ini
echo "fourth_tier_5_campaign_boss_challenges=5" >> randomizerlauncheryaml.ini
echo "third_tier_5_campaign_boss_challenges=2" >> randomizerlauncheryaml.ini
echo "final_campaign_boss_campaign_opponents=12" >> randomizerlauncheryaml.ini
echo "fourth_tier_5_campaign_boss_campaign_opponents=7" >> randomizerlauncheryaml.ini
echo "third_tier_5_campaign_boss_campaign_opponents=3" >> randomizerlauncheryaml.ini
echo "number_of_challenges=10" >> randomizerlauncheryaml.ini
echo "starting_money=3000" >> randomizerlauncheryaml.ini
echo "money_reward_multiplier=20" >> randomizerlauncheryaml.ini
echo "normalize_boosters_packs=true" >> randomizerlauncheryaml.ini
echo "booster_pack_prices=100" >> randomizerlauncheryaml.ini
echo "add_empty_banlist=false" >> randomizerlauncheryaml.ini
echo "campaign_opponents_shuffle=false" >> randomizerlauncheryaml.ini
echo "ocg_arts=false" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
rom_hash="2832602615"
rom_filename_pattern="*[Yy]u*[Gg]i*[Oo]h*.gba"
rom_base_path="$BaseGameDir/$BaseGBADir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
found_rom_path=""
echo "" >> randomizerlauncheryaml.ini
echo "[zillion-a-yaml]" >> randomizerlauncheryaml.ini
echo "YAMLFilePath=/media/fat/Scripts/randomizers/yamls/zillion/MiSTerPlayerZillion.yaml" >> randomizerlauncheryaml.ini
echo "progression_balancing=50" >> randomizerlauncheryaml.ini
echo "accessibility=items" >> randomizerlauncheryaml.ini
echo "continues=3" >> randomizerlauncheryaml.ini
echo "floppy_req=5" >> randomizerlauncheryaml.ini
echo "gun_levels=balanced" >> randomizerlauncheryaml.ini
echo "jump_levels=balanced" >> randomizerlauncheryaml.ini
echo "randomize_alarms=true" >> randomizerlauncheryaml.ini
echo "max_level=8" >> randomizerlauncheryaml.ini
echo "opas_per_level=2" >> randomizerlauncheryaml.ini
echo "early_scope=false" >> randomizerlauncheryaml.ini
echo "skill=2" >> randomizerlauncheryaml.ini
echo "starting_cards=2" >> randomizerlauncheryaml.ini
echo "id_card_count=42" >> randomizerlauncheryaml.ini
echo "bread_count=50" >> randomizerlauncheryaml.ini
echo "opa_opa_count=26" >> randomizerlauncheryaml.ini
echo "zillion_count=8" >> randomizerlauncheryaml.ini
echo "floppy_disk_count=7" >> randomizerlauncheryaml.ini
echo "scope_count=4" >> randomizerlauncheryaml.ini
echo "red_id_card_count=2" >> randomizerlauncheryaml.ini
echo "start_inventory=null" >> randomizerlauncheryaml.ini
echo "start_char=random" >> randomizerlauncheryaml.ini
rom_hash="340769465"
rom_filename_pattern="Zillion \(UE\) \[\!\].sms"
rom_base_path="$BaseGameDir/$BaseSMSDir/"
locate_rom_yaml
echo "rom_path=$found_rom_path" >> randomizerlauncheryaml.ini
echo "" >> randomizerlauncheryaml.ini
found_rom_path=""
