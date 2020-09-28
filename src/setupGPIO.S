.section .text
.align 2
.globl setupGPIO

.include "memory_map.inc"
.include "gpio.inc"


#assembly function
setupGPIO:
    addi sp, sp, -16            #allocate the stack frame
    sw ra, 12(sp)               #save the return address into the stack - protects the address in case it gets overwritten

    li t0, GPIO_CTRL_ADDR       #load the base GPIO address
    li t1, GPIO_RGB_PINS        #get the RGB_PINS offset
    sw t1, GPIO_OUTPUT_EN(t0)   #enable output on the RGB_PIN so they are writeable
    sw t1, GPIO_OUTPUT_XOR(t0)  #set the XOR so the RGB_PIN are active high (instead of default set as low)
    sw x0, GPIO_OUTPUT_VAL(t0)  #set all writeable pins to 0 to clear the LEDs

    lw ra, 12(sp)               #restore the return address
    addi sp, sp, 16             #deallocationg the stack frame
    ret

