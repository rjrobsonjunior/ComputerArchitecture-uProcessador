# ComputerArchitecture-uProcessador


## Registradores

| Endereço | Descrição
| -        | - 
| 0        | zero
| 1        | --
| 2..      | --

## Formatos das Intruções
I: 
| Imm(9)  | rd(3) | Opcode(4)
| --      | --    | --

R:
| Free(3) | rs2(3) | rs1(3)  | rd(3) | Opcode(4)
| --      |--      | --      | --    | --

B:
| address(6) | rs1(3) | rd(3)  | Opcode(4)
| --         |--      | --      | --

## Instruções

Os opcodes são formados pelos 5 bits menos significativos. 
| n| Mnemônico | Opcode | tipo 
|--| --        |--      |--
| 1| lw        | 0000   | I   
| 2|add        | 0001   | R   
| 3| sub       | 0010   | R   
| 4|xor        | 0011   | R   
| 5|and        | 0100   | R   
| 6| beq       | 0101   | B   
| 7| bge       | 0110   | B   
| 8| blt       | 0111   | B   
| 9| bne       | 1000   | B   
|10| addi      | 1001   | B 
|12| subi      | 1010   | B   
|16| jump      | 1111   | B