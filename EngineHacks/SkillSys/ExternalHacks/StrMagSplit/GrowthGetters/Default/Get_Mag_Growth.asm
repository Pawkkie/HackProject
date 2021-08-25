.thumb
.org 0x0

.set MagCharTable, Extra_Growth_Boosts+4
.set MagClassTable, MagCharTable+4
.set ClassGrowthOption, MagClassTable+4

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
ldr		r3, MagClassTable
lsl		r2, #2 @multiplies class ID number by 4 (4 columns in table, move through each entry to get to the right class's row)
add		r2, #1 @adds 1 (2nd column has the growth value)
ldrb	r2, [r3, r2] @load value at MagClassTable + offset in r2, which is the location of the value (ie. skip over every other entry in the table to get to where this is)
add		r1, r2

GetExtraGrowthBoost:
mov		r2,#11		@index of str boost
ldr		r3,Extra_Growth_Boosts
bx		r3

.align
Extra_Growth_Boosts:
@
