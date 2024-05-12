library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionDecoder is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        ula_selector : out unsigned(1 downto 0 );
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ula_input_instrI, ula_input_InstrB : out unsigned( 15 downto 0) -- value form instruction type I and B, like addi, subi, be 
    );
end entity InstructionDecoder;

architecture rtl of InstructionDecoder is
signal Iinstruction, Binstruction, Rinstruction : std_logic;
begin
    ----------------------- 
    Binstruction <= '1' when instruction(3 downto 0) = "0101" else --beq
                            '1' when instruction(3 downto 0) = "0110" else --bge
                            '1' when instruction(3 downto 0) = "0111" else --blt
                            '1' when instruction(3 downto 0) = "1000" else --bne
                            '1' when instruction(3 downto 0) = "1001" else --addi
                            '1' when instruction(3 downto 0) = "1010" else --subi
                            '1' when instruction(3 downto 0) = "1111" else --jump
                            '0';
    B_format_instruction <= Binstruction;
    
    Iinstruction <= '1' when instruction(3 downto 0) = "0100" else -- lw
                            '1' when instruction(3 downto 0) = "1011" else -- sw
                            '0';
    I_format_instruction <= Iinstruction;



    Rinstruction <= '1' when instruction(3 downto 0) = "0000" else --add
                            '1' when instruction(3 downto 0) = "0001" else --sub
                            '1' when instruction(3 downto 0) = "0010" else --xor
                            '1' when instruction(3 downto 0) = "0011" else --and
                            '0';
    R_format_instruction <= Rinstruction;

    ula_selector <= "00" when instruction(3 downto 0) = "1001" else --addi
                    "00" when instruction(3 downto 0) = "0000" else  --add
                    "01" when instruction(3 downto 0) = "1010" else --subi
                    "01" when instruction(3 downto 0) = "0001" else --sub
                    "10" when instruction(3 downto 0) = "0010" else --xor
                    "10" when instruction(3 downto 0) = "0011" else --and
                    "11";

    ula_input_instrI <= "0000000"&instruction(15 downto 7) when Iinstruction = '1' else
                        x"0000";
    
    ula_input_instrB <= "0000000000"&instruction(15 downto 10) when Iinstruction = '1' else
                        x"0000";
    
end architecture;