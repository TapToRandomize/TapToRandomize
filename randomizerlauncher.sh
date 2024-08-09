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
cotm_options(){
        echo -e "ignoreCleansing $COTMignoreCleansing \napplyAutoRunPatch $COTMapplyAutoRunPatch " > "options.txt"
        echo -e "applyNoDSSGlitchPatch $COTMapplyNoDSSGlitchPatch \napplyAllowSpeedDash $COTMapplyAllowSpeedDash " >> options.txt
        echo -e "breakIronMaidens $COTMbreakIronMaidens \nlastKeyRequired $COTMlastKeyRequired " >> options.txt
        echo -e "lastKeyAvailable $COTMlastKeyAvailable \napplyBuffFamiliars $COTMapplyBuffFamiliars " >> options.txt
        echo -e "applyBuffSubweapons $COTMapplyBuffSubweapons \napplyShooterStrength $COTMapplyShooterStrength " >> options.txt
        echo -e "doNotRandomizeItems $COTMdoNotRandomizeItems \nRandomItemHardMode $COTMRandomItemHardMode " >> options.txt
        echo -e "halveDSSCards $COTMhalveDSSCards \ncountdown $COTMcountdown \nsubweaponShuffle $COTMsubweaponShuffle " >> options.txt
        echo -e "noMPDrain $COTMnoMPDrain \nallBossesRequired $COTMallBossesRequired \ndssRunSpeed $COTMdssRunSpeed " >> options.txt
        echo -n -e "skipCutscenes $COTMskipCutscenes \nskipMagicItemTutorials $COTMskipMagicItemTutorials " >> options.txt
}
build_options_flags_sj(){
        SJOptionsString=""
        if [ $SolarJetmanRandomizeAstronaut ]; then
                SJOptionsString="-a $SJOptionsString"
        fi
        if [ $SolarJetmanRandomizePod ]; then
                SJOptionsString="-r $SJOptionsString"
        fi
        if [ $SolarJetmanRandomizeItems ]; then
                SJOptionsString="-i $SJOptionsString"
        elif [ $SolarJetmanRandomizeItemsWithLogic ]; then
                SJOptionsString="-I $SJOptionsString"
        fi
        if [ $SolarJetmanLateral ]; then
                SJOptionsString="-l $SJOptionsString"
        fi
        if [ $SolarJetmanSeed ]; then
                SJOptionsString="--seed $SolarJetmanSeed $SJOptionsString"
        fi
        if [ "$SolarJetmanMode" == "normal" -o $SolarJetmanMode == "reckless" -o $SolarJetmanMode == "goldhunt" ] ; then
                SJOptionsString="--mode $SolarJetmanMode $SJOptionsString"
        fi
}
solarjetman(){
        BaseRandoDir=$BaseGameDir/$BaseNesDir/$SolarJetmanRandoDir
        shift_old_seeds
        if [ ! -e .venvsj/bin/activate ]; then
            python -m venv .venvsj
        fi
        source .venvsj/bin/activate
        pip install sj-rando
        build_options_flags_sj
        sj-rando $SJOptionsString --rompath "${SolarJetmanRom}"
        deactivate
        mv *.nes "$BaseRandoDir/current"
        SystemForAutolaunch="NES"
}
alttp(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$ALTTPRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$ALTTPPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
dkc3(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$DKC3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$DKC3PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
cv64(){
        BaseRandoDir=$BaseGameDir/$BaseN64Dir/$CV64RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$CV64PlayerDir
        ArchipelagoFileEnding='.z64'
        archipelago_generate 
        SystemForAutolaunch="N64"
}
kdl3(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$KDL3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$KDL3PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
loz(){
        BaseRandoDir=$BaseGameDir/$BaseNesDir/$LOZRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$LOZPlayerDir
        ArchipelagoFileEnding='.nes'
        archipelago_generate 
        SystemForAutolaunch="NES"
}
l2(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$L2RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$L2PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
mmbn3(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$MMBN3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$MMBN3PlayerDir
        ArchipelagoFileEnding='.gba'
        archipelago_generate 
        SystemForAutolaunch="GBA"
}
oot(){
        BaseRandoDir=$BaseGameDir/$BaseN64Dir/$OOTRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$OOTPlayerDir
        ArchipelagoFileEnding='.z64'
        archipelago_generate
        SystemForAutolaunch="N64"
}
pokee(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$PokeERandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$PokeEPlayerDir
        ArchipelagoFileEnding='.gba'
        archipelago_generate 
        SystemForAutolaunch="GBA"
}
pokerb(){
        BaseRandoDir=$BaseGameDir/$BaseGameboyDir/$PokeRBRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$PokeRBPlayerDir
        ArchipelagoFileEnding='.gb'
        archipelago_generate 
        SystemForAutolaunch="GAMEBOY"
}
smw(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMWRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMWPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
smz3(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMZ3RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMZ3PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
soe(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SOERandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SOEPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
sm(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMRandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMPlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
         SystemForAutolaunch="SNES"
}
yoshi(){
        BaseRandoDir=$BaseGameDir/$BaseSnesDir/$SMW2RandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$SMW2PlayerDir
        ArchipelagoFileEnding='.sfc'
        archipelago_generate 
        SystemForAutolaunch="SNES"
}
yugioh06(){
        BaseRandoDir=$BaseGameDir/$BaseGBADir/$YGORandoDir
        shift_old_seeds
        ArchipelagoPlayerDir=$BaseYamlDir/$YGOPlayerDir
        ArchipelagoFileEnding='.gba'
        archipelago_generate 
        SystemForAutolaunch="GBA"
}
zillion(){
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
               alttp "A Link to the Past SNES (Archipelago)"
               dkc3 "Donkey Kong Country 3 SNES (Archipelago)"
               cv64 "Castlevania 64 (Archipelago)"
               kdl3 "Kirby's Dream Land 3 (Archipelago)"
               loz "The Legend of Zelda NES (Archipelago)"
               l2 "Lufia 2 Ancient Caves SNES (Archipelago)"
               mmbn3 "Mega Man Battle Network 3 GBA (Archipelago)"
               pokerb "Pokemon Red/Blue GB (Archipelago)"
               sm "Super Metroid SNES (Archipelago)"
               smw "Super Mario World SNES (Archipelago)"
               soe "Secret of Evermore SNES (Archipelago)"
               smz3 "Super Metroid/A Link to the Past Combo SNES (Archipelago)"
               yoshi "Yoshi's Island SNES (Archipelago)"
               yugioh06 "YuGiOh Ultimate Masters 2006 GBA (Archipelago)"
               zillion "Zillion SMS (Archipelago)"
               dq3 "Dragon's Quest 3 Super Famicom (cleartonic)"
               cotm "Circle of the Moon (calm-palm)")

        choice=$(dialog --title "TapToRandomize Launcher" \
                         --menu "Select a randomizer to launch" 50 90 999 "${items[@]}" \
                         2>&1 >/dev/tty2)
        case $choice in
                solarjetman) solarjetman ;; 
                alttp) alttp ;; 
                dkc3) dkc3 ;;
                cv64) cv64 ;;
                kdl3) kdl3 ;;
                loz) loz ;;     
                l2) l2 ;;
                mmbn3) mmbn3 ;;
#        Commented out as it doesn't currently run on MiSTer; left for future fix
#                oot) oot ;;
#                pokee) pokee ;;
                pokerb) pokerb ;;    
                smw) smw ;;
                smz3) smz3 ;;
                soe) soe ;;
                sm) sm ;;
                yoshi) yoshi ;;  
                yugioh06) yugioh06 ;;
                zillion) zillion ;;
                dq3) dq3 ;;
                cotm) cotm ;;
                *) clear
                exit 0 ;;
        esac
        autoload=1
        clear # clear after user pressed Cancel
        
}
case $1 in
        solarjetman) solarjetman ;;
        alttp) alttp ;;
        dkc3) dkc3 ;;
        cv64) cv64 ;;
        kdl3) kdl3 ;;
        loz) loz ;;
        l2) l2 ;;
        mmbn3) mmbn3 ;;
#        Commented out as it doesn't currently run on MiSTer; left for future fix
#        oot) oot ;;
#        pokee) pokee ;;
        pokerb) pokerb ;;    
        smw) smw ;;
        smz3) smz3 ;;
        soe) soe ;;
        sm) sm ;;
        yoshi) yoshi ;;  
        yugioh06) yugioh06 ;;
        zillion) zillion ;;
        dq3) dq3 ;;
        cotm) cotm ;;
        *) call_menu ;;
        #No valid argument entered, start up the menu if we can
esac
if [ "$2" == "autoload" ]; then
        autoload=1
fi
if [ $autoload ]; then
        $RandomizerBasedir/mbc load_rom $SystemForAutolaunch $BaseRandoDir/current/*
fi