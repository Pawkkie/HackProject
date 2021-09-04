@	VANILLA @ 0x0802A73C
@	mov	r0, #0x1
@	neg	r0, r0
@	cmp	r3, r0
@	bne	EnemyExists
@	CheckWeaponSlot:
@	mov r0, r5
@	blh GetUnitEquippedWeaponSlot, r1 @ bl 0x08016B58
@	mov r3, r0
@	EnemyExists:


@	MODIFIED
.thumb
.equ GetUnitEquippedWeaponSlot, 0x08016B58
push		{r3}
bl GetUnitEquippedWeaponSlot
pop		{r3}
cmp		r0, #9
beq OverwriteR3
mov r1, #0x1
neg r1, r1
cmp r3, r1
bne EnemyExists
OverwriteR3:
mov r3, r0
EnemyExists:


@	NEW
nop
nop
nop
nop
mov r0, r5
bl 0x08016B58
mov r0, #0x1
@	mov	r0, #0x1
@	neg	r0, r0
@	cmp	r3, r0
@	bne	EnemyExists