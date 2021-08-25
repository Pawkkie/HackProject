.thumb
.org 0x0

@17E5C

@r0,r5, are free, r3 is free but needs to be 0 at the end
ldrb	r0,[r1,#0x4]		@char num
ldr		r3,MagCharTable
lsl		r0,#0x1
add		r0,r3
mov		r3,#0x0
ldsb	r0,[r0,r3]			@char base
ldrb	r5,[r2,#0x4]		@class num
lsl		r5,#0x2
ldr		r3,MagCharTable+4	@MagClassTable
add		r5,r3
mov		r3,#0x0
ldsb	r5,[r5,r3]			@class base

@Mag
push	{r2}
push	{r1}
ldrb	r2,[r1,#0x4]
ldr		r1,MagCharTable+8	@SeparateUnitBasesTable
ldrb	r2,[r1,r2]
cmp		r2,#1
beq		DoneAddingMag
add		r0,r0,r5
DoneAddingMag:
pop		{r1}
pop		{r2}
mov		r3,r4
add		r3,#0x3A
strb	r0,[r3]
mov		r3,#0x0
ldrb	r5,	[r2, #0xF]
ldrb	r0,	[r1, #0x10]

@Def
push	{r2}
push	{r1}
ldrb	r2,[r1,#0x4]
ldr		r1,MagCharTable+8	@SeparateUnitBasesTable
ldrb	r2,[r1,r2]
cmp		r2,#1
beq		DoneAddingDef
add		r0,r0,r5
DoneAddingDef:
strb	r0, [r4, #0x17]
pop		{r1}
pop		{r2}

@Res
@ldrb 	r0, [r2, #0x10]
@ldrb 	r2, [r1, #0x11]

ldrb 	r2, [r2, #0x10]
ldrb 	r0, [r1, #0x11]

push	{r3}
push	{r1}
ldrb	r3,[r1,#0x4]
ldr 	r1,MagCharTable+8	@SeparateUnitBasesTable
ldrb	r3, [r1, r3]
cmp		r3, #1
beq		DoneAddingRes
add		r0,r0,r2
DoneAddingRes:
strb	r0,[r4, #0x18]
pop		{r1}
pop		{r3}	
bx		r14

.align
.pool
MagCharTable:
