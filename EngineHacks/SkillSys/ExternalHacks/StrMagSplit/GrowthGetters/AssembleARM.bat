@echo off

@rem Assemble into an elf
SET startDir="D:\Kyle\FireEmblemHack\HackProject\EventAssembler\ASM\devkitARM\bin\"
SET as="%startDir%arm-none-eabi-as"
%as% -g -mcpu=arm7tdmi -mthumb-interwork %1 -o "%~n1.elf"

@rem Print symbol table
SET readelf="%startDir%arm-none-eabi-readelf"
%readelf% -s "%~n1.elf" > "%~n1.symbols.log"

@rem Extract raw assembly binary (text section) from elf
SET objcopy="%startDir%arm-none-eabi-objcopy"
%objcopy% -S "%~n1.elf" -O binary "%~n1.dmp"

echo y | del "%~n1.elf"
echo y | del "%~n1.symbols.log"
pause