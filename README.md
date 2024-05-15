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
| Imm(6) | rs1(3) | rd(3)  | Opcode(4)
| --     |--      | --     | --

## Instruções

Os opcodes são formados pelos 4 bits menos significativos. 
| n| Mnemônico | Opcode | tipo 
|--| --        |--      |--  
| 1| nop       | 0000   | n   
| 2| add       | 0001   | R   
| 3| sub       | 0010   | R   
| 4| xor       | 0011   | R 
| 5| and       | 0100   | R   
| 6| beq       | 0101   | B   
| 7| bge       | 0110   | B   
| 8| blt       | 0111   | B   
| 9| bne       | 1000   | B   
|10| addi      | 1001   | I 
|11| sw        | 1010   | I 
|12| lw        | 1011   | I 
|13| ld        | 1100   | I
|: |   :       |   :    | :    
|16| jump      | 1111   | B
