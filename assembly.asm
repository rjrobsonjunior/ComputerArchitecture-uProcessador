//(A) carrega na RAM os valores 0 a 7384
ld r7, 1 //registrador reservado para fazer adição, substituir o addi 1
//A.1 0 - 2047
ld r1, 0
movA r1
add r7
movR r1
sw  r1
cmp 2047
jz -4
//A.2 2047 - 4095
movR r2
movA r1
add r7
movR r1
sw  r1
sub r2
cmp 2047
jz -6
//A.3 4095 - 6141
movR r2
movA r1
add r7
movR r1
sw  r1
sub r2
cmp 2047
jz -6
//A.3 4094 - 6141
ld r3 1243
add r3
movR r2
movA r1
add r7
movR r1
sw  r1
sub r2
cmp 2047
jz -6

//(B) para o intervalo de [2, 90] zero na RAM todos multiplos do mesmo

ld r1, 1
movA r1
add r7(addi 1)
add r1
movR r2
movA r0
sw r2
cmp 1024
jz -7
cmp 32
jz -9
