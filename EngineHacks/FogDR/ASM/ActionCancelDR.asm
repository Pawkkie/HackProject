@ Recalc DR when cancelling a move.
@ Hooked at 0x1D028
.thumb

push  {r4, r14}


bic   r0, r1
str   r0, [r2, #0xC]
ldr   r4, =RefreshFogAndUnitMaps
bl    GOTO_R4

@ Recalc DR if it's active.
ldr   r0, =DRCountByte
lsl   r0, #0x5
lsr   r0, #0x5
ldrb  r0, [r0]
cmp   r0, #0x0
beq   L1

  @ Re-add active unit to gMapUnit to update DR during movement.
  @ Calculate active unit's location.
  ldr   r1, =ActiveUnit
  ldr   r1, [r1]
  ldrb  r0, [r1, #0x10]                     @ X-coordinate.
  ldrb  r2, [r1, #0x11]                     @ Y-coordinate.
  lsl   r2, #0x2                            @ Quadruple for row pointers.
  ldrb  r1, [r1, #0xB]                      @ Deployment slot.
  ldr   r3, =UnitMap
  ldr   r3, [r3]
  ldr   r3, [r3, r2]                        @ Go to Y-coordinate.
  add   r3, r0                              @ Go to X-coordinate.

  @ 'Overflow' check. Make sure we're still in gMapUnitPool.
  ldr   r0, =gMapTerrainPool
  cmp   r3, r0
  bge   L1

    @ Re-add active unit.
    strb  r1, [r3]
    
    @ Calculate DR
    bl    InitializeDR
    
    @ Remove active unit from unit map again.
    ldr   r0, =UnitMap
    ldr   r0, [r0]
    mov   r1, #0x0
    ldr   r4, =ClearMapWith
    bl    GOTO_R4
    ldr   r4, =UpdateUnitMapAndVision
    bl    GOTO_R4
    b     Return
    
L1:

ldr   r4, =UpdateGameTilesGraphics
bl    GOTO_R4


Return:
pop   {r4}
pop   {r0}
bx    r0
GOTO_R4:
bx    r4
