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
| Free(3) | rs2(3) | rs1(3)  | rd(3) | Opcode(4)
| --      | --      | --      | --    | --

B:
| Imm(6) | rs1(3) | rd(3)  | Opcode(4)
| --         |--      | --      | --

## Instruções

Os opcodes são formados pelos 5 bits menos significativos. 
| n| Mnemônico | Opcode | tipo 
|--| --        |--      |--  
| 1| add       | 0000   | R   
| 2| sub       | 0001   | R   
| 3| xor       | 0010   | R   
| 4| and       | 0011   | R  
| 5| lw        | 0100   | I  
| 6| beq       | 0101   | B   
| 7| bge       | 0110   | B   
| 8| blt       | 0111   | B   
| 9| bne       | 1000   | B   
|10| addi      | 1001   | B 
|12| subi      | 1010   | B 
|: |   :       |   :    | :    
|16| jump      | 1111   | B