.section .text
.align 2
.globl delay

.include "memory_map.inc"

delay:
    addi sp, sp, -16        #steup the stack frame
    sw ra, 12(sp)           #save return address

    li t0, MTIME            #load the timer register value
    lw t1, 0(t0)            #load current value of the timer

    li t2, MTIME_FREQUENCY  #get clock frequency 
    mul t2, t2, a0          #multiply time in milliseconds(a0 - delay time) with frequency
    add t2, t1, t2          #target mtime is now allocated in t2


1:                          #go backwards
    lw t1, 0(t0)            #read mtime value again
    blt t1, t2, 1b          #keep looping till time out (go back to "1:") - (btl: if less than)

    lw ra, 12(sp)           #restore the return address
    addi sp, sp, 16         #deallocate the stack frame
    ret 