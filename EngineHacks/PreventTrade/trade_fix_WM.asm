.thumb
.org 0 @paste to e184c-8b4
.align 4
@at 9b550 write 46f07cf9
@need to save r0 actually

@change r1,r2 to r0,r1
@change r4,r5 to r2,r3

push {r4-r6,lr}
mov r6,r0    @save r0 for later
mov r5,r1    @save inventory ptrs
ldrb r0,[r4] @get item data

mov r2, #0 @Counter 
ldr r3, =PreventTradingList 
PreventTradingLoopA:
ldrb r1, [r3, r2] 
cmp r1, #0x0 
beq ContinueA
add r2, #1 
cmp r0, r1 @
beq NoTrade
b PreventTradingLoopA
ContinueA:
ldrb r0,[r5]

mov r2, #0 @Counter 
ldr r3, =PreventTradingList 
PreventTradingLoopB:
ldrb r1, [r3, r2] 
cmp r1, #0x0 
beq ContinueB
add r2, #1 
cmp r0, r1 @
beq NoTrade
b PreventTradingLoopB
ContinueB: 

ldrh r1,[r5]
ldrh r0,[r4]

@ items to swap between units in r0 and r1 
mov r2, #0xC0 @ 0x40|0x80 forged / equipped? (forgable items is disabled anyway)
lsl r2, #8 

@ Check if itemID stored at the address in r4 has the "IsAccsesory" weapon ability, and if it does, unequip it before trading
push {r1-r3}
ldr r3, =ItemTable
ldrb r2,[r4] @ itemID
mov r1, #0x24 @ width of item table
mul r2, r1 @ multiply itemID by width of table
add r2, #0xA @ offset to the column for Weapon Ability 3, which can contain IsAccessory (0x40)
ldrb r2, [r3,r2] @ Get value in weapon ability 3
mov r3, #0x40 @ Setup to compare WA3 with IsAccessory
and r3, r2
mov r1, #0x0
cmp r3, r1
beq NotAccessory1 @ if NOT = 0, go to NotAccessory1
pop {r1-r3}
bic r0, r2 @ remove top 2 bits of durability, i think 
b CheckAcc1End
NotAccessory1:
pop {r1-r3}
CheckAcc1End:

@ Check if itemID stored at the address in r5 has the "IsAccessory" weapon ability, and if it does, unequip it before trading
push {r1-r3}
ldr r3, =ItemTable
ldrb r2,[r5] @ itemID
mov r1, #0x24 @ width of item table
mul r2, r1 @ multiply itemID by width of table
add r2, #0xA @ offset to the column for Weapon Ability 3, which can contain IsAccessory (0x40)
ldrb r2, [r3,r2] @ Get value in weapon ability 3
mov r3, #0x40 @ Setup to compare WA3 with IsAccessory
and r3, r2
mov r1, #0x0
cmp r3, r1
beq NotAccessory2 @ if NOT = 0, go to NotAccessory1
pop {r1-r3}
bic r1, r2 @ remove top 2 bits of durability, i think 
b CheckAcc2End
NotAccessory2:
pop {r1-r3}
CheckAcc2End:

strh r1,[r4]
strh r0,[r5]
mov r0,r6
b End
NoTrade:
ldr r0, MuteCheck
ldrb r0,[r0]
lsl r0,r0,#0x1e
cmp r0,#0
blt Mute
mov r0,#0x6c
ldr r1, PlaySound
mov lr,r1
.short 0xF800
Mute:
pop {r4-r6}
pop {r0}
pop {r4-r6}
pop {r0}
ldr r0, ReturnSkip
bx r0
End:
pop {r4-r6}
pop {r1}
bx r1
.align
AbilityGetter:
.long 0x0801756c
PlaySound:
.long 0x080d01fc
ReturnSkip:
@.long 0x0809be1b
.long 0x0809bc89
MuteCheck:
.long 0x0202bc31
