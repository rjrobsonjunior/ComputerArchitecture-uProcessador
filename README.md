# ComputerArchitecture-uProcessador


## Registradores

| Endereço | Descrição
| -        | - 
| 0        | zero
| 1        | --
| 2..      | --

## Instruções

Os opcodes são formados pelos 5 bits menos significativos. Os 6 bits mais significativos é o operando. Segue tabela de instruções:

| Instrução | Opcode | Operando | Descrição     | status
| -         | -      | -        | -             | -
| adc zpg   | 65     | adr      | A += mem[adr] | ok
| adc imm   | 69     | val      | A += val      | ok
| sbc imm   | E9     | val      | A -= val      | ok
| sta       | 85     | adr      | mem[adr] = A  | ok
| lda imm   | A9     | val      | A = val       | ok
| lda zpg   | A5     | adr      | A = mem[adr]  | ok
| jmp       | 4C     | adr      | PC = adr      | ok