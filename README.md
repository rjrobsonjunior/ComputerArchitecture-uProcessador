# ComputerArchitecture-uProcessador


## Registradores

| Endereço | Descrição
| -        | - 
| 0        | zero
| 1        | r1
| 2        | r2
| 3        | r3
| 4        | r4
| :        | :


## Formatos das Intruções
I: 
| Imm(9)  | rd(3) | Opcode(4)
| --      | --    | --

R:
| Free(9) | rd(3) | Opcode(4)
| --      | --    | --    

B:
| Imm(12) | Opcode(4)
| --      | --

## Instruções

Os opcodes são formados pelos 4 bits menos significativos. 
| n| Mnemônico | Opcode | tipo | descrição
|--| --        |--      |--    | --
| 1| nop       | 0000   | n    | ..
| 2| add       | 0001   | R    | A += rd
| 3| sub       | 0010   | R    | A -= rd
| 4| xor       | 0011   | R    | A =xor rd
| 5| and       | 0100   | R    | A =and rd
| 6| jz        | 0101   | B    | 
| 7| jc        | 0110   | B    |
| 8| cmp       | 0111   | I    |    
| 9| ld        | 1000   | I    | rd = Imm
|10| addi      | 1001   | I    | A += Imm
|. | ...       | ...    | .    | ...
|12| lw        | 1011   | R    | 
|13| sw        | 1100   | R    | 
|14| movA      | 1101   | R    | A = rd
|15| movR      | 1110   | R    | rd = A
|16| jump      | 1111   | B    |
