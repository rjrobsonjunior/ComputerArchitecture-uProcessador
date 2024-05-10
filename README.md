# ComputerArchitecture-uProcessador


## Registradores

| Endereço | Descrição
| -        | - 
| 0        | zero
| 1        | --
| 2..      | --

## Formatos das Intruções
I: 
| Imm(8)  | rd(3) | Opcode(5)
| --      | --    | --

R:
| Free(2) | rs2(3) | rs1(3)  | rd(3) | Opcode(5)
| --      |--      | --      | --    | --

B:
| address(5) | rs2(3) | rs1(3)  | Opcode(5)
| --         |--      | --      | --
## Instruções

Os opcodes são formados pelos 5 bits menos significativos. 
| Mnemônico | Opcode | tipo 
| -         | -      | -
| lw        | 00000  | I   
| add       | 00001  | R   
| sub       | 00011  | R   
| xor       | 00100  | R   
| and       | 00101  | R   
| beq       | 00110  | B   
| bge       | 00111  | B   
| blt       | 01000  | B   
| bne       | 01001  | B   
| addi      | 01010  | B   
| sw        | 01011  | B   