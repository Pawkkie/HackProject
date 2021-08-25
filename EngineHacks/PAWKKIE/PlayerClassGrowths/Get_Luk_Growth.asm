.thumb
.org 0x0

.equ ClassGrowthOption, Extra_Growth_Boosts+4
.equ PlayerClassGrowthsTable, ClassGrowthOption+4

@r0=battle struct or char data ptr
@Need to use an extra register to do the negative check
push	{r4}
ldr		r1,[r0]
add		r1,#34
ldrb	r1,[r1]		@luk growth
ldr 	r2,ClassGrowthOption
cmp		r2,#0
beq		GetExtraGrowthBoost

ldr		r2, [r0,#4]
ldrb	r2, [r2,#4] @gets the class ID number as seen in the class editor table
ldr		r3, PlayerClassGrowthsTable
lsl		r2, #4 @multiplies class ID number by 16 (16 columns in table, move through each entry to get to the right class's row)

mov		r4, r2

add		r2, #0xE @adds offset to negative check column
ldrb	r2, [r3, r2] @load value
cmp		r2, #0 @see if value is zero; if 0, growth is positive. If 1, growth is negative.
beq		PositiveGrowth

@NegativeGrowth
mov		r2, r4
add		r2, #6 @adds offset to correct growth
ldrb	r2, [r3, r2] @load value

@If negative class growth would make total growth less than zero, instead make it zero; otherwise, do the subtraction
cmp		r1, r2
bge		DoGrowthSubtraction
mov		r1,#0
b		GetExtraGrowthBoost
DoGrowthSubtraction:
sub		r1, r2 @subtract value from character growth
b		GetExtraGrowthBoost


PositiveGrowth:
mov		r2, r4
add		r2, #6 @adds offset to correct growth
ldrb	r2, [r3, r2] @load value 
add		r1, r2 @add value to character growth

GetExtraGrowthBoost:
pop		{r4}
mov		r2,#16		@index of luk boost
ldr		r3,Extra_Growth_Boosts
bx		r3

.align
Extra_Growth_Boosts:
@
