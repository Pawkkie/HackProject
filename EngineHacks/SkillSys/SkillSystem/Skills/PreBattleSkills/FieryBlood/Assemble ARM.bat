@echo off

SET devkitDir=D:\Kyle\FireEmblemHack\HackProject\EventAssembler\ASM\devkitARM\bin\
SET as=%devkitDir%arm-none-eabi-as

@rem Assemble into an elf
%as% -g -mcpu=arm7tdmi -mthumb-interwork %1 -o "%~n1.elf"

@rem Extract raw assembly binary (text section) from elf
SET objcopy="%devkitDir%arm-none-eabi-objcopy"
%objcopy% -S "%~n1.elf" -O binary "%~n1.dmp"

echo y | del "%~n1.elf"
pause