@echo off

@rem USAGE: "MAKE HACK_full.cmd" [quick]
@rem If first argument is "quick", then this will not update text, tables, or generate a patch
@rem "MACK HACK_quick.cmd" simply calls this but with the quick argument, for convenience

@rem defining buildfile config

set "source_rom=%~dp0\ROMs\Clean\FE8_clean.gba"

set "main_event=%~dp0ROM Buildfile.event"

set "target_rom=%~dp0\ROMs\FE8_hack.gba"
set "target_ups=%~dp0\ROMs\FE8_hack.ups"

@rem defining tools

set "c2ea=%~dp0Tools\SkillSys\C2EA\c2ea"
set "textprocess=%~dp0Tools\SkillSys\TextProcess\textprocess-classic-narrow"
set "ups=%~dp0Tools\SkillSys\ups\ups"
set "parsefile=%~dp0Event Assembler\Tools\ParseFile.exe"

@rem set %~dp0 into a variable because batch is stupid and messes with it when using conditionals?

set "base_dir=%~dp0"

@rem do the actual building

echo Copying ROM

copy "%source_rom%" "%target_rom%"

if /I not [%1]==[quick] (

  @rem only do the following if this isn't a make hack quick

  echo:
  echo Processing tables

  cd "%base_dir%Tables"
  echo: | ("%c2ea%" "%source_rom%")

  echo:
  echo Processing text

  cd "%base_dir%Text/SkillSys"
  echo: | (textprocess-classic-narrow text_buildfile.txt)
  cd "%base_dir%Text"
  echo: | (textprocess-classic-narrow TextBuildfile.txt)
)

echo:
echo Assembling

cd "%base_dir%EventAssembler"
ColorzCore A FE8 "-output:%target_rom%" "-input:%main_event%" "--nocash-sym"

if /I not [%1]==[quick] (

  @rem only do the following if this isn't a make hack quick

  echo:
  echo Generating patch

  cd "%base_dir%"
  "%ups%" diff -b "%source_rom%" -m "%target_rom%" -o "%target_ups%"

)

echo:
echo Done!

pause
