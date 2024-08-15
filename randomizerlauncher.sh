#!/bin/bash
RandomizerBasedir=/media/fat/Scripts/randomizers
BaseGameDir=/media/fat/cifs/games
BaseYamlDir=$RandomizerBasedir/yamls
BaseSnesDir=SNES
BaseNesDir=NES
BaseGameboyDir=GAMEBOY
BaseGBADir=GBA
BaseN64Dir=N64
BaseGenesisDir=Genesis
BaseSMSDir=SMS
TmpDir=$RandomizerBasedir/taptorandomizetmp
ArchipelagoDir=$RandomizerBasedir/archipelago-0.5.0-MiSTerFPGA
SolarJetmanRandoDir=SolarJetmanRando
SolarJetmanRom='/media/fat/cifs/games/NES/randoroms/Solar Jetman - Hunt for the Golden Warpship (USA).nes'
SolarJetmanRandomizeAstronaut=0
SolarJetmanRandomizePod=0
SolarJetmanRandomizeItems=1
SolarJetmanRandomizeItemsWithLogic=0
olarJetmanRandomizePallette=1
SolarJetmanLateral=0
SolarJetmanSeed=-1
SolarJetmanMode=normal
ALTTPRandoDir=ALTTPRando
ALTTPPlayerDir=alttp
DKC3RandoDir=DKC3Rando
DKC3PlayerDir=dkc3
CV64RandoDir=CV64Rando
CV64PlayerDir=cv64
KDL3RandoDir=KDL3Rando
KDL3PlayerDir=kdl3
LOZRandoDir=LOZRando
LOZPlayerDir=loz
L2RandoDir=L2Rando
L2PlayerDir=lufia2
MMBN3RandoDir=MMBN3Rando
MMBN3PlayerDir=mmbn3
#PokeERandoDir=PokemonEmeraldRando
#PokeEPlayerDir=pokemonemerald
#OOTRandoDir=OOTRando
#OOTPlayerDir=oot
PokeRBRandoDir=PokeRBRando
PokeRBPlayerDir=pokemonrb
SMWRandoDir=SMWRando
SMWPlayerDir=smw
SMZ3RandoDir=SMZ3Rando
SMZ3PlayerDir=smz3
SOERandoDir=SOERando
SOEPlayerDir=soe
BaseRandoDir=/tmp/rando/
SMRandoDir=SMRando
SMPlayerDir=supermetroid
SMW2RandoDir=YIRando
SMW2PlayerDir=yoshi
YGORandoDir=YGORando
YGOPlayerDir=yugioh
DQ3RandoDir=DQ3Rando
DQ3RomPath='/media/fat/cifs/games/SNES/randoroms/dq3.smc'
ZillionRandoDir=ZillionRando
ZillionPlayerDir=zillion
COTMRandoDir=COTMRando
COTMRomPath='/media/fat/cifs/games/GBA/randoroms/cotm.gba'
COTMignoreCleansing=0 
COTMapplyAutoRunPatch=0 
COTMapplyNoDSSGlitchPatch=0 
COTMapplyAllowSpeedDash=0 
COTMbreakIronMaidens=0 
COTMlastKeyRequired=0 
COTMlastKeyAvailable=0 
COTMapplyBuffFamiliars=0 
COTMapplyBuffSubweapons=0 
COTMapplyShooterStrength=0 
COTMdoNotRandomizeItems=0 
COTMRandomItemHardMode=0 
COTMhalveDSSCards=0 
COTMcountdown=0 
COTMsubweaponShuffle=0 
COTMnoMPDrain=0 
COTMallBossesRequired=0 
COTMdssRunSpeed=1 
COTMskipCutscenes=0 
COTMskipMagicItemTutorials=0 
COTMnerfRocWing=0
ARRomPath='/media/fat/cifs/games/SNES/randoroms/ar.sfc'
ARRandoDir=ARRando
ARExtraLives=0
ARUnlimitedLives=0
ARDeathCount=1
ARSwordUpgrade=0
ARMarhana='N'
ARBossRush='C'
BOF3Abilities=1
BOF3Characters=1
BOF3Enemies=0
BOF3DragonLoc=0
BOF3Masters=0
BOF3Items=1
BOF3Shops=1
BOF3Treasure=1
BOF3RandoDir=BOF3Rando
BOF3RomPath='/media/fat/cifs/games/PSX/randoroms/bof3.iso'
FFL2Evolutions=1
FFL3Formations=1
FFL2Items=1
FFL2MonsterSkills=1
FFL2MonsterStats=1
FFL2MutantSkills=1
FFL2Shops=1
FFL2Treasure=1


SystemForAutolaunch=none
KeepSeeds=5

#Handle ini file if it exists
INI_PATH=/media/fat/Scripts/randomizerlauncher.ini
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
}
bof3vv(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$BOF3RandoDir
        shift_old_seeds
        EnvIdentifier="bof3"
        cd randomizers/bof3_vast_violence
        setupPythonEnv
        bof3vv_options
        python randomizer.py $bof3vv_options
        mv *.iso $BaseRandoDir/current/
        cd ../../
        deactivate
}
ffl2(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$FFL2RandoDir
        shift_old_seeds
        EnvIdentifier="ffl2"
        cd randomizers/ffl2mp
        setupPythonEnv
        ffl2_options
        python randomizer.py $ffl2_options
        mv *.gb $BaseRandoDir/current/
        cd ../../
        deactivate
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
               ffl2 "Final Fantasy Legend 2 GB (Abyssonym)")

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
        *) call_menu ;;
        #No valid argument entered, start up the menu if we can
esac
if [ "$2" == "autoload" ]; then
        autoload=1
fi
if [ $autoload ]; then
        $RandomizerBasedir/mbc load_rom $SystemForAutolaunch $BaseRandoDir/current/*
fi
