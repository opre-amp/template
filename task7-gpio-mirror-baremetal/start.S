.section ".text.startup" // Where to link the contents of this file
.global _start           // Export this function
_start:                  // First routine to be called
    ldr sp,=0x30000000   // Set the stack pointer to a high enough address
    mrc p15,0,r1,c1,c0,0 // Read the configuration register
    orr r1,r1,#0x1800    // Enable the L1 cache and the branch predictor
    mcr p15,0,r1,c1,c0,0 // Write back to the configuration register
    bl main              // Branch with link to main (returnable branch)
    ldr r1,=0x400000fc   // Load the address of the mailbox clear register
    ldr r3,=0xffffffff   // Zero out the mailbox (clear register -> inv.)
    str r3, [r1]         // 
    mov r3, #0           // Comparison value
_check_loop:             // Loop to check jump address
    ldr r2, [r1]         // Get its value
    cmp r1, r3           // Is it null?
    beq _check_loop      // If yes, loop around
    bx  r1               // If not, jump to the address
