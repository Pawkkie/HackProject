.thumb

@HP
ldr		r2,[r4,#0x4]
ldrb	r3,[r2,#0xB]
ldrb	r0,[r1,#0xC]

@Need to use these registers to check boolean
push	{r2}
push	{r1}

@Load in boolean from CSV to determine whether or not to add class bases to character bases
ldrb	r2,[r1,#0x4] @ Load in character number as seen in table
ldr 	r1,SeparateUnitBasesTable
ldrb	r2, [r1, r2]

@See if we add or not
cmp		r2, #1 @ See if value is 1, if so don't add class base
beq		DontAdd
add		r0,r0,r3 @Finish adding HP
pop		{r1} @Put these registers back now that our check is done
pop		{r2}
mov		r3,#0x0
strb	r0,[r4,#0x12] @Finish storing HP

@Str
ldrb	r0,[r2,#0xC]
ldrb	r5,[r1,#0xD]
add		r0,r0,r5
strb	r0,[r4,#0x14]

@Skl
ldrb	r0,[r2,#0xD]
ldrb	r5,[r1,#0xE]
add		r0,r0,r5
strb	r0,[r4,#0x15]

@Spd
ldrb	r0,[r2,#0xE]
ldrb	r5,[r1,#0xF]
add		r0,r0,r5
strb	r0,[r4,#0x16]
b		Done

DontAdd:
pop		{r1} @Put these registers back now that our check is done
pop		{r2}
mov		r3,#0x0
strb	r0,[r4,#0x12] @Finish storing HP

@Str
ldrb	r0,[r1,#0xD]
strb	r0,[r4,#0x14]

@Skl
ldrb	r0,[r1,#0xE]
strb	r0,[r4,#0x15]

@Spd
ldrb	r0,[r1,#0xF]
strb	r0,[r4,#0x16]

Done:	
ldr		r3, =0x8017E5B
bx		r3

.align
.pool
SeparateUnitBasesTable:
@
