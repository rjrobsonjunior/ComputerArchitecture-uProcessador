//(A) carrega na RAM os valores 0 a 7384
ld r10, 1 //registrador reservado para fazer adição, substituir o addi 1
//A.1 0 - 2047
ld r1, 0
movA r1
add r10
movR r1
lw r1
cmp 2047
jz -4
//A.2 2047 - 4094
movR r2
movA r1
add r10
movR r1
lw r1
sub r2
cmp 2047
jz -6
//A.3 4094 - 6141
movR r2
movA r1
add r10
movR r1
lw r1
sub r2
cmp 2047
jz -6
//A.3 4094 - 6141
ld r3 1243
add r3
movR r2
movA r1
add r10
movR r1
lw r1
sub r2
cmp 2047
jz -6


//(B) para todos os valores da RAM, zero todos multiplos do mesmo


ld r1, 2
movA r1
add r1
cmp 32

