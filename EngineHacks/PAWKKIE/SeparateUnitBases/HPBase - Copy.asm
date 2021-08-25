.thumb

@Copying over lines
ldr		r2,[r4,#0x4]
ldrb	r3,[r2,#0xB]
ldrb	r0,[r1,#0xC]
push	{r2}
push	{r1}

ldrb	r2,[r1,#0x4] @ Load in character number as seen in table
ldr 	r1,SeparateUnitBasesTable
ldrb	r2, [r1, r2]

@Use unit ID to index table, if 1 skip to DoneAdding
cmp		r2, #1 @ See if value is 1, if so don't add class base
beq		DoneAdding
add		r0,r0,r3

DoneAdding:
pop		{r1}
pop		{r2}	
ldr		r3, =0x8017E41
bx		r3

.align
.pool
SeparateUnitBasesTable:
@
