#include <ppc-asm.h>

.global get_run_1fr_asm
.global get_run_1fr_asm_end

.macro defaultInstruction
    addi sp, sp, 16
.endm

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

get_run_1fr_asm_end:
    mflr r12
    b get_run_1fr_asm_end_b
get_run_1fr_asm:
    mflr r12
bl blTrickCommonEnd
run_1fr_asm:

	pushStack
	bl run_1fr
	popStack
    defaultInstruction

    .long 0
get_run_1fr_asm_end_b:
    bl blTrickCommonEnd