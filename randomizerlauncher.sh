#!/bin/bash


#Handle ini file
INI_PATH=/media/fat/Scripts/randomizerlauncher.ini
if [ ! -f $INI_PATH ]
then
    randomizerlaunchersetup.sh
fi
if [ -f $INI_PATH ]
then
        source <(grep = $INI_PATH|tr -d '\r')
fi

shift_old_seeds(){
        mkdir -p $BaseRandoDir/current
        mkdir -p $BaseRandoDir/archive
        SeedInCurrent=$(ls -1 $BaseRandoDir/current | wc -l)
        if (( SeedInCurrent > 0 )); then
                for filename in $BaseRandoDir/current/*; do
                        mv "$filename" $BaseRandoDir/archive
                done
                cd $BaseRandoDir/archive
                ls -1tr | head -n -$KeepSeeds | xargs -d '\n' rm -f --
                cd /media/fat/Scripts
        fi;
}
archipelago_generate(){
        python $RandomizerBasedir/yamlupdater.py
        mkdir -p $TmpDir
        rm -Rf $TmpDir/*
        cp $BaseYamlDir/host.yaml $ArchipelagoDir/
        $ArchipelagoDir/ArchipelagoGenerate --player_files_path $ArchipelagoPlayerDir
        unzip $TmpDir/*.zip -d $TmpDir/
        $ArchipelagoDir/ArchipelagoPatch $TmpDir/AP_*P1*.ap*
        cp $TmpDir/AP*$ArchipelagoFileEnding $BaseRandoDir/current
        rm -Rf $TmpDir/*
}
actraiser_optionstring(){
        aroptions=''
        if (( ARExtraLives > 0 )); then
                aroptions="-E $aroptions"
        fi
        if (( ARUnlimitedLives > 0 )); then
                aroptions="-U $aroptions"
        fi
        if (( ARDeathCount > 0 )); then
                aroptions="-D $aroptions"
        fi
        if (( ARSwordUpgrade > 0 )); then
                aroptions="-Z $aroptions"
        fi
        case $ARMarhana in
                L) aroptions="-L $aroptions" ;;
                R) aroptions="-R $aroptions" ;;
        esac
        case $ARBossRush in
                C) aroptions="-C $aroptions" ;;
                S) aroptions="-S $aroptions" ;;
        esac
        seed=$RANDOM
        aroptions="$aroptions -s $seed -o $BaseRandoDir/current/$seed.sfc $ARRomPath"
        echo "$aroptions"
}
bof3vv_options(){
        bof3vvoptions='-'
        if (( BOF3Abilities > 0 )); then
                bof3vvoptions="{$bof3vvoptions}a"
        fi
        if (( BOF3Characters > 0 )); then
                bof3vvoptions="{$bof3vvoptions}c"
        fi
        if (( BOF3Enemies > 0 )); then
                bof3vvoptions="{$bof3vvoptions}e"
        fi
        if (( BOF3DragonLoc > 0 )); then
                bof3vvoptions="{$bof3vvoptions}g"
        fi
        if (( BOF3Masters > 0 )); then
                bof3vvoptions="{$bof3vvoptions}m"
        fi
        if (( BOF3Itemsc > 0 )); then
                bof3vvoptions="{$bof3vvoptions}q"
        fi
        if (( BOF3Shops > 0 )); then
                bof3vvoptions="{$bof3vvoptions}s"
        fi
        if (( BOF3Treasure > 0 )); then
                bof3vvoptions="{$bof3vvoptions}t"
        fi        
        seed=$RANDOM
        bof3vvoptions="$bof3vvoptions $BOF3RomPath $seed"
        echo "$bof3vvoptions"
}
ffl2_options(){
	    ffl2options='-'
        if (( FFL2Evolutions > 0 )); then
                ffl2options="{$ffl2options}e"
        fi
        if (( FFL2Formations > 0 )); then
                ffl2options="{$ffl2options}f"
        fi
        if (( FFL2Items > 0 )); then
                ffl2options="{$ffl2options}i"
        fi
        if (( FFL2MonsterSkills > 0 )); then
                ffl2options="{$ffl2options}k"
        fi
        if (( FL2MonsterStats > 0 )); then
                ffl2options="{$ffl2options}m"
        fi
        if (( FFL2MutantSkills > 0 )); then
                ffl2options="{$ffl2options}u"
        fi
        if (( FFL2Shops > 0 )); then
                ffl2options="{$ffl2options}s"
        fi
        if (( FFL2Treasure > 0 )); then
                ffl2options="{$ffl2options}t"
        fi        
        seed=$RANDOM
        ffl2options="$ffl2options $FFL2RomPath $seed"
        echo "$ffl2options"
}
fft_options(){
		fftoptions='-'
        if (( FFTAbilities > 0 )); then
                fftoptions="{$fftoptions}a"
        fi
        if (( FFTMusic > 0 )); then
                fftoptions="{$fftoptions}c"
        fi
        if (( FFTFormations > 0 )); then
                fftoptions="{$fftoptions}f"
        fi
        if (( FFTJobInnates > 0 )); then
                fftoptions="{$fftoptions}i"
        fi
        if (( FFTJobStats > 0 )); then
                fftoptions="{$fftoptions}j"
        fi
        if (( FFTShop > 0 )); then
                fftoptions="{$fftoptions}p"
        fi
        if (( FFTMaps > 0 )); then
                fftoptions="{$fftoptions}m"
        fi
        if (( FFTTrophies > 0 )); then
                fftoptions="{$fftoptions}t"
        fi
        if (( FFTUnits > 0 )); then
                fftoptions="{$fftoptions}u"
        fi
        if (( FFTWeapons > 0 )); then
                fftoptions="{$fftoptions}w"
        fi
        if (( FFTStatus > 0 )); then
                fftoptions="{$fftoptions}y"
        fi        
        seed=$RANDOM
        fftoptions="$fftoptions $FFL2RomPath $seed"
        echo "$fftoptions"
}
cotm_options(){
        echo -e "ignoreCleansing $COTMignoreCleansing #boolean\napplyAutoRunPatch $COTMapplyAutoRunPatch #boolean" > "options.txt"
        echo -e "applyNoDSSGlitchPatch $COTMapplyNoDSSGlitchPatch #boolean\napplyAllowSpeedDash $COTMapplyAllowSpeedDash #boolean" >> options.txt
        echo -e "breakIronMaidens $COTMbreakIronMaidens #boolean\nlastKeyRequired $COTMlastKeyRequired #int" >> options.txt
        echo -e "lastKeyAvailable $COTMlastKeyAvailable #int\napplyBuffFamiliars $COTMapplyBuffFamiliars #boolean" >> options.txt
        echo -e "applyBuffSubweapons $COTMapplyBuffSubweapons #boolean\napplyShooterStrength $COTMapplyShooterStrength #boolean" >> options.txt
        echo -e "doNotRandomizeItems $COTMdoNotRandomizeItems #boolean\nRandomItemHardMode $COTMRandomItemHardMode #boolean" >> options.txt
        echo -e "halveDSSCards $COTMhalveDSSCards #boolean\ncountdown $COTMcountdown #boolean\nsubweaponShuffle $COTMsubweaponShuffle #boolean" >> options.txt
        echo -e "noMPDrain $COTMnoMPDrain #boolean\nallBossesRequired $COTMallBossesRequired #boolean\ndssRunSpeed $COTMdssRunSpeed #boolean" >> options.txt
        echo -n -e "skipCutscenes $COTMskipCutscenes #boolean\nskipMagicItemTutorials $COTMskipMagicItemTutorials #boolean\nnerfRocWing $COTMnerfRocWing #boolean" >> options.txt
}
megaman_options(){
	    mmoptions = ""
	    if (( MegaManWeapons == 0 )); then
			    mmoptions = "-w $mmoptions"
		fi
	    if (( MegaManPalette == 0 )); then
			    mmoptions = "-p $mmoptions"
		fi
	    if (( MegaManWeakness > 0 )); then
			    mmoptions = "+weakness $mmoptions"
		fi
	    if (( MegaManBossDamage > 0 )); then
			    mmoptions = "+damagetoboss $mmoptions"
		fi
	    if (( MegaManMusic > 0 )); then
			    mmoptions = "+music $mmoptions"
		fi
	    if (( MegaManRoll > 0 )); then
			    mmoptions = "+roll $mmoptions"
		fi
		mmoptions = "$mmoptions -i $MegaManRomPath -o $BaseRandoDir/current/"	
}
build_options_flags_sj(){
        SJOptionsString=""
        if [ "$SolarJetmanRandomizeAstronaut" == "1" ]; then
                SJOptionsString="-a $SJOptionsString"
        fi
        if [ "$SolarJetmanRandomizePod" == "1" ]; then
                SJOptionsString="-r $SJOptionsString"
        fi
        if [ "$SolarJetmanRandomizeItems" == "1" ]; then
                SJOptionsString="-i $SJOptionsString"
        elif [ "$SolarJetmanRandomizeItemsWithLogic" == "1" ]; then
                SJOptionsString="-I $SJOptionsString"
        fi
        if [ "$SolarJetmanLateral" == "1" ]; then
                SJOptionsString="-l $SJOptionsString"
        fi
        if [ "$SolarJetmanRandomizePallette" == "1" ]; then
                SJOptionsString="-p $SJOptionsString"
        fi
        if [ "$SolarJetmanSeed" -gt 0 ]; then
                SJOptionsString="--seed $SolarJetmanSeed $SJOptionsString"
        fi
        if [ "$SolarJetmanMode" == "normal" -o $SolarJetmanMode == "reckless" -o $SolarJetmanMode == "goldhunt" ] ; then
                SJOptionsString="--mode $SolarJetmanMode $SJOptionsString"
        fi
        echo "$SJOptionsString"
}
setupPythonEnv(){
        python -m ensurepip
        if [ ! -e .venv$EnvIdentifier/bin/activate ]; then
            python -m venv .venv$EnvIdentifier
        fi
        . .venv$EnvIdentifier/bin/activate
}
ar(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$ARRandoDir
        shift_old_seeds
        EnvIdentifier="ar"
        cd randomizers/actraiser-randomizer/
        setupPythonEnv
        actraiser_optionstring
        python actraiser_randomizer.py $aroptions
        cd ../../
        deactivate
        SystemForAutoLaunch=SNES
}
bof3vv(){
        BaseRandoDir=$BaseGameDir/$BasePSXDir/$BOF3RandoDir
        shift_old_seeds
        EnvIdentifier="bof3"
        cd randomizers/bof3_vast_violence
        setupPythonEnv
        bof3vv_options
        python randomizer.py $bof3vvoptions
        mv *.iso $BaseRandoDir/current/
        cd ../../
        deactivate
        SystemForAutoLaunch=PSX
}
ffl2(){
        BaseRandoDir=$BaseGameDir/$BaseGameboyDir/$FFL2RandoDir
        shift_old_seeds
        EnvIdentifier="ffl2"
        cd randomizers/ffl2mp
        setupPythonEnv
        ffl2_options
        python randomizer.py $ffl2options
        mv *.gb $BaseRandoDir/current/
        cd ../../
        deactivate
        SystemForAutoLaunch=GAMEBOY
}
fft(){
        BaseRandoDir=$BaseGameDir/$BasePSXDir/$FFTRandoDir
        shift_old_seeds
        EnvIdentifier="fft"
        cd randomizers/fftrctcr
        setupPythonEnv
        fft_options
        python randomizer.py $fftoptions
        mv *.iso $BaseRandoDir/current/
        cd ../../
        deactivate
        SystemForAutoLaunch=PSX
}
mg(){
	    BaseRandoDir=$BaseGameDir/$BaseMSXDir/$MGRandoDir
	    shift_old_seeds
	    EnvIdentifier="mg"
	    cd randomizers/mg-random/
	    cp $MGRomPath ./
	    python server2.py
	    cp random.rom $BaseRandoDir/current/$RANDOM.rom
	    rm *.rom
	    cd ../../
	    SystemForAutoLaunch=MSX
	    
}
mn64(){
		BaseRandoDir=$BaseGameDir/$BaseN64Dir/$MN64RandoDir
	    shift_old_seeds
	    cd randomizers/mn64rando/
	    export MN64_CONFIG=/media/fat/Scripts/mn64settings.yaml
	    python randomizer.py $MN64RomPath
	    mv *.z64 $BaseRandoDir/current
	    cd ../../
	    SystemForAutoLaunch=N64
}
landstalker(){
		BaseRandoDir=$BaseGameDir/$BaseGenesisDir/$LandstalkerRandoDir
	    shift_old_seeds
	    cd randomizers/randstalker/
	    ./randstalker --inputRom=$LandstalkerRomPath --outputRom=$BaseRandoDir/current --noPause --ingametracker --preset=presets/$LandstalkerPreset
	    cd ../../
	    SystemForAutoLaunch=Genesis
}
sr(){
	    BaseRandoDir=$BaseGameDir/$BaseSnesDir/$ShadowrunRandoDir
	    shift_old_seeds
	    cd randomizers/shadowrun-randomizer
	    seed=$RANDOM
	    python shadowrun_randomizer.py -s $seed -o "$BaseRandoDir/current/$seed.sfc" "$ShadowrunRomPath"
	    cd ../../
	    SystemForAutoLaunch=SNES
}
alttp-door(){
	    BaseRandoDir=$BaseGameDir/$BaseSnesDir/$ALTTPDRandoDir
	    shift_old_seeds
	    cd randomizers/ALttPDoorRandomizer
	    EnvIdentifier="alttpd"
	    setupPythonEnv
	    python -m pip install aenum fast-enum python-bps-continued aioconsole websockets colorama pyyaml --cache-dir=/media/fat/Scripts/randomizers/taptorandomizetmp/
	    python DungeonRandomizer.py --rom "$ALTTPDRomPath" --shuffle full --outputpath $BaseRandoDir/current --suppress_spoiler
	    deactivate
	    cd ../../
	    SystemForAutoLaunch=SNES
}
gs(){
	    BaseRandoDir=$BaseGameDir/$BaseGBADir/$GSRandoDir
	    shift_old_seeds
	    cd randomizers/GS-Randomizer
	    EnvIdentifier="gs"
	    setupPythonEnv
	    python -m pip install hjson
	    cp $GSRomPath ./GOLDEN_SUN_A_AGSE00.gba
	    python randomizer.py /media/fat/Scripts/randomizers/jsons/GoldenSun.json
	    rm GOLDEN_SUN_A_AGSE00.gba
	    cp *.gba $BaseRandoDir/current/
	    cd ../../
	    SystemForAutoLaunch=GBA
}
ladx(){
	    BaseRandoDir=$BaseGameDir/$BaseGameboyDir/$LADXRandoDir
	    shift_old_seeds
	    cd randomizers/LADXR
	    python main.py --spoilerformat none $LADXRomPath
	    mv *.gbc $BaseRandoDir/current
	    SystemForAutoLaunch="GAMEBOY" 
}
solarjetman(){
        BaseRandoDir=$BaseGameDir/$BaseNesDir/$SolarJetmanRandoDir
        shift_old_seeds
        EnvIdentifier="sj"
        setupPythonEnv
        python -m pip install sj-rando
        build_options_flags_sj
        sj-rando $SJOptionsString --rompath "${SolarJetmanRom}"
        deactivate
        mv *.nes "$BaseRandoDir/current"
        SystemForAutolaunch="NES"
}
alttp-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$ALTTPRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$ALTTPPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
dkc3-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$DKC3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$DKC3PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
cv64-a(){
        BaseRandoDir=$BaseGameDir/$BaseN64Dir/$CV64RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$CV64PlayerDir
        ArchipelagoFileEnding='.z64'
        archipelago_generate 
        SystemForAutolaunch="N64"
}
kdl3-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$KDL3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$KDL3PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
loz-a(){
        BaseRandoDir=$BaseGameDir/$BaseNesDir/$LOZRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$LOZPlayerDir
        ArchipelagoFileEnding='.nes'
        archipelago_generate 
        SystemForAutolaunch="NES"
}
l2-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$L2RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$L2PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
mmbn3-a(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$MMBN3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$MMBN3PlayerDir
        ArchipelagoFileEnding='.gba'
        archipelago_generate 
        SystemForAutolaunch="GBA"
}
oot-a(){
        BaseRandoDir=$BaseGameDir/$BaseN64Dir/$OOTRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$OOTPlayerDir
        ArchipelagoFileEnding='.z64'
        archipelago_generate
        SystemForAutolaunch="N64"
}
pokee-a(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$PokeERandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$PokeEPlayerDir
        ArchipelagoFileEnding='.gba'
        archipelago_generate 
        SystemForAutolaunch="GBA"
}
pokerb-a(){
        BaseRandoDir=$BaseGameDir/$BaseGameboyDir/$PokeRBRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$PokeRBPlayerDir
        ArchipelagoFileEnding='.gb'
        archipelago_generate 
        SystemForAutolaunch="GAMEBOY"
}
smw-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMWRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMWPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
smz3-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMZ3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMZ3PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
soe-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SOERandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SOEPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
sm-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
         SystemForAutolaunch="SNES"
}
yoshi-a(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMW2RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMW2PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
yugioh06-a(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$YGORandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$YGOPlayerDir
        ArchipelagoFileEnding='.gba'
        archipelago_generate 
        SystemForAutolaunch="GBA"
}
zillion-a(){
        BaseRandoDir=$BaseGameDir/$BaseSMSDir/$ZillionRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$ZillionPlayerDir
        ArchipelagoFileEnding='.sms'
        archipelago_generate 
        SystemForAutolaunch="SMS"
}
dq3(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$DQ3RandoDir
        shift_old_seeds
        mkdir -p $RandomizerBasedir/dq3hf/dev/
        echo "$DQ3RomPath" > $RandomizerBasedir/dq3hf/dev/path.txt
        cd $RandomizerBasedir/dq3hf
        python $RandomizerBasedir/dq3hf/randomizer.py
        cp $DQ3RomPath $BaseRandoDir/current/$RANDOM.sfc
        files=($BaseRandoDir/current/*.sfc)
        $RandomizerBasedir/dq3hf/asar/asar --fix-checksum=off --no-title-check "$RandomizerBasedir/dq3hf/asar/patch.asm" "${files[0]}"
        rm $RandomizerBasedir/dq3hf/asar/patch_r.asm
        cd /media/fat/Scripts/
        SystemForAutolaunch="SNES"
}
cotm(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$COTMRandoDir
        shift_old_seeds
        seed=$RANDOM
        cp $COTMRomPath $BaseRandoDir/current/$seed.gba
        files=($BaseRandoDir/current/*.gba)
        cd $RandomizerBasedir/cotm-randomizer/Program/
        rm seed.txt
        echo "$seed"> seed.txt 
        cotm_options
        rando "${files[0]}" headless
        cd /media/fat/Scripts
        SystemForAutolaunch="GBA"
}
call_menu(){

        items=(solarjetman "Solar Jetman NES (akerasi)"
               alttp-a "A Link to the Past SNES (Archipelago)"
               dkc3-a "Donkey Kong Country 3 SNES (Archipelago)"
               cv64-a "Castlevania 64 (Archipelago)"
               kdl3-a "Kirby's Dream Land 3 (Archipelago)"
               loz-a "The Legend of Zelda NES (Archipelago)"
               l2-a "Lufia 2 Ancient Caves SNES (Archipelago)"
               mmbn3-a "Mega Man Battle Network 3 GBA (Archipelago)"
               pokerb-a "Pokemon Red/Blue GB (Archipelago)"
               sm-a "Super Metroid SNES (Archipelago)"
               smw-a "Super Mario World SNES (Archipelago)"
               soe-a "Secret of Evermore SNES (Archipelago)"
               smz3-a "Super Metroid/A Link to the Past Combo SNES (Archipelago)"
               yoshi-a "Yoshi's Island SNES (Archipelago)"
               yugioh06-a "YuGiOh Ultimate Masters 2006 GBA (Archipelago)"
               zillion-a "Zillion SMS (Archipelago)"
               dq3 "Dragon's Quest 3 Super Famicom (cleartonic)"
               cotm "Circle of the Moon (calm-palm)"
               ar "Actraiser Randomizer (Osteoclave)"
               bof3vv "Breath of Fire 3 PSX (Abyssonym)"
               ffl2 "Final Fantasy Legend 2 GB (Abyssonym)"
               fft "Final Fantasy Tactics PSX (Abyssonym)"
               mg "Metal Gear MSX (Wijnen)"
               landstalker "Landstalker Genesis (Dinopony)"
               sr "Shadowrun SNES (Osteoclave)"
               alttp-door "A Link To The Past Door Randomizer SNES (aerinon)"
               ladx "Link's Awakening DX (daid)")

        choice=$(dialog --title "TapToRandomize Launcher" \
                         --menu "Select a randomizer to launch" 50 90 999 "${items[@]}" \
                         2>&1 >/dev/tty2)
        case $choice in
                solarjetman) solarjetman ;; 
                alttp-a) alttp-a ;; 
                dkc3-a) dkc3-a ;;
                cv64-a) cv64-a ;;
                kdl3-a) kdl3-a ;;
                loz-a) loz-a ;;     
                l2-a) l2-a ;;
                mmbn3-a) mmbn3-a ;;
#        Commented out as it doesn't currently run on MiSTer; left for future fix
#                oot-a) oot-a ;;
#                pokee-a) pokee-a ;;
                pokerb-a) pokerb-a ;;    
                smw-a) smw-a ;;
                smz3-a) smz3-a ;;
                soe-a) soe-a ;;
                sm-a) sm-a ;;
                yoshi-a) yoshi-a ;;  
                yugioh06-a) yugioh06-a ;;
                zillion-a) zillion-a ;;
                dq3) dq3 ;;
                cotm) cotm ;;
                ar) ar ;;
                bof3vv) bof3vv ;;
                ffl2) ffl2 ;;
                fft) fft ;;
                mg) mg ;;
                landstalker) landstalker ;;
                sr) sr ;;
                alttp-door) alttp-door ;;
                ladx) ladx ;;
#                gs) gs ;;
                *) clear
                exit 0 ;;
        esac
        autoload=1
        clear # clear after user pressed Cancel
        
}
case $1 in
        solarjetman) solarjetman ;;
        alttp-a) alttp-a ;;
        dkc3-a) dkc3-a ;;
        cv64-a) cv64-a ;;
        kdl3-a) kdl3-a ;;
        loz-a) loz-a ;;
        l2-a) l2-a ;;
        mmbn3-a) mmbn3-a ;;
#        Commented out as it doesn't currently run on MiSTer; left for future fix
#        oot-a) oot-a ;;
#        pokee-a) pokee-a ;;
        pokerb-a) pokerb-a ;;    
        smw-a) smw-a ;;
        smz3-a) smz3-a ;;
        soe-a) soe-a ;;
        sm-a) sm-a ;;
        yoshi-a) yoshi-a ;;  
        yugioh06-a) yugioh06-a ;;
        zillion-a) zillion-a ;;
        dq3) dq3 ;;
        cotm) cotm ;;
        ar) ar ;;
        bof3vv) bof3vv ;;
        ffl2) ffl2 ;;
        fft) fft ;;
        mg) mg ;;
#commented out because, although it technically works, it takes a LITERAL hour.
#        mn64) mn64 ;;
        landstalker) landstalker ;;
        sr) sr ;;
        alttp-door) alttp-door ;;
#commented out because underlying randomizer doesn't function on default seed; may fix it for them.'
#        gs) gs ;;
        ladx) ladx ;;
        *) call_menu ;;
        #No valid argument entered, start up the menu if we can
esac
if [ "$2" == "autoload" ]; then
        autoload=1
fi
if [ $autoload ]; then
        $RandomizerBasedir/mbc load_rom $SystemForAutolaunch $BaseRandoDir/current/*
fi
