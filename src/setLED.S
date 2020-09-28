.section .text
.align 2
.globl setLED

.include "memory_map.inc"
.include "gpio.inc"

.equ NOERROR,   0x0
.equ ERROR,     0x1
.equ LEDON,     0x1

#which LED to set comes into register a0
#desired on/off state comes into register a1

setLED:
    addi sp, sp, -16            #allocate stack frame
    sw ra, 12(sp)               #save return address onto the stack 

    li t0, GPIO_CTRL_ADDR       #load the gpio address
    lw t1, GPIO_OUTPUT_VAL(t0)  #get the current value of the pins

    beqz a1, ledOff             #branch off to turn off led if a1 requests it - (beqs: if equal to 0) if a1 is equal to 0 go to ledoff
    li t2, LEDON                #load up ON(1) into the temp register
    beq a1, t2, ledOn           #if a1 and t2 are equal then branch of to ledOn 
    li a0, ERROR                #if received a bad request, return error
    j exit                      #offset  jump

ledOn:
    xor t1, t1, a0              #XOR will only change the value of the requested led
    sw t1, GPIO_OUTPUT_VAL(t0)  #write the new output value to the gpio output
    li a0, NOERROR
    j exit


ledOff:
    xor a0, a0, 0xffffffff      #with xor only the bit we are trying to change will be set to 0
    and t1, t1, a0              #And the values to only turn off the requested bit
    sw t1, GPIO_OUTPUT_VAL(t0)  #write the new output value to the right gpio register
    li a0, NOERROR

exit:
    lw ra, 12(sp)               #restore the return address
    addi sp, sp, 16             #deallocating the stack frame
    ret




