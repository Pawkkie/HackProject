.thumb
.org 0x0

.set MagCharTable, Extra_Growth_Boosts+4
.set PlayerClassGrowthsTable, MagCharTable+4
.set ClassGrowthOption, PlayerClassGrowthsTable+4

@r0=battle struct or char data ptr
ldr		r1,[r0]
ldrb	r1,[r1,#4]	@unit ID growth
ldr 	r2, MagCharTable
lsl 	r1, #1 @index in mag char table
add 	r1, #1 @growth
ldrb 	r1, [r2, r1]
ldr 	r2,ClassGrowthOption
cmp		r2,#0
beq		GetExtraGrowthBoost

ldr		r2, [r0,#4]
ldrb	r2, [r2,#4] @gets the class ID number as seen in the class editor table
ldr		r3, PlayerClassGrowthsTable
lsl		r2, #3 @multiplies class ID number by 8 (8 columns in table, move through each entry to get to the right class's row)
add		r2, #7 @adds offset to correct growth
ldrb	r2, [r3, r2] @load value 
add		r1, r2

GetExtraGrowthBoost:
mov		r2,#11		@index of str boost
ldr		r3,Extra_Growth_Boosts
bx		r3

.align
Extra_Growth_Boosts:
@
