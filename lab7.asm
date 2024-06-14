start:
    ld r1, 0x69
    ld r3, 0x2
    movA r1
    sw r3
    movA r0
    lw r3
    movA r0
                
    ld r7, 0x1
    ld r6, 0xAA
    movA r7
    sw r6
    movA r0
    lw r6
    movA r0
                
    ld r1, 0x8
    movA r0
    addi 0xBA
    sw r1
    movA r1
    addi 0x1
    movR r1
                
    ld r1, 0x9
    movA r0
    addi 0xBA
    sw r1
    movA r1
    addi 0x1
    movR r1
                
    ld r1, 0xA
    movA r0
    addi 0xCA
    sw r1
                
    ld r2, 0x8
    ld r3, 0x9
    ld r4, 0xA
                
    lw r2
    movA r0
                
    lw r3
    movA r0
                
    lw r4
    movA r0
