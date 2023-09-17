#include <ppc-asm.h>

.global getSceneID
.global blTrickCommonEnd
.global ICInvalidateRangeAsm
.global OSLaunchTitleHookAsm
.global OSLaunchTitleHookAsmEnd

.macro pushStack
    stwu sp, -0x80 (sp)#124 + パディング
    mflr r0
    stw r0, 0x84 (sp)
    stmw r3, 8 (sp)
.endm

.macro popStack
    lmw r3, 8 (sp)
    lwz r0, 0x84 (sp)
    mtlr r0
    addi sp, sp, 0x80
.endm

#by vega
#https://mariokartwii.com/showthread.php?tid=1218


ICInvalidateRangeAsm:
	cmplwi r4, 0   # zero or negative size?
	blelr
	clrlwi. r5, r3, 27  # check for lower bits set in address
	beq 1f
	addi r4, r4, 0x20 
1:
	addi r4, r4, 0x1f
	srwi r4, r4, 5
	mtctr r4
2:
	icbi r0, r3
	addi r3, r3, 0x20
	bdnz 2b
	sync
	isync
	blr

blTrickCommonEnd:
    mflr r3
    mtlr r12
    blr

getSceneID:
    lis r3,menu_pointer@ha
    lwz r3,menu_pointer@l (r3)
    cmpwi r3,0
    beq- skip_all
    lwz r3,0(r3)
    cmpwi r3,0
    beq- skip_all
    lwz r3,0(r3)
    skip_all:
    blr

OSLaunchTitleHookAsm:
pushStack
bl OSLaunchTitleHook
popStack
stwu sp, -0x20 (sp)
.long 0
.long 0
OSLaunchTitleHookAsmEnd: