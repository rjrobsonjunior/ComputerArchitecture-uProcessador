library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionDecoder is
    port (
        clk, clkFetch  : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        ula_selector : out unsigned(1 downto 0 );
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ula_input_Instruction : out unsigned( 15 downto 0); -- value form instruction type I and B, like addi, subi, be 
        addressReg1 : out unsigned( 2 downto 0)
        );
end entity InstructionDecoder;

architecture rtl of InstructionDecoder is
    component reg16bits is
        port( clk      : in std_logic;
              rst      : in std_logic;
              wr_en    : in std_logic;
              data_in  : in unsigned(15 downto 0);
              data_out : out unsigned(15 downto 0)
        );
    end component;
    
signal Iinstruction, Binstruction, Rinstruction : std_logic;
signal InstructionSave : unsigned (15 downto 0);
signal tmpImmI : unsigned (6 downto 0);
signal tmpImmB : unsigned (9 downto 0);
begin
    componentInstruction : reg16bits port map (
        clk      => clk,
        rst      => reset,
        wr_en    => clkFetch,
        data_in  => instruction,
        data_out => InstructionSave
    );
    ----------------------- 
    Binstruction <= '1' when InstructionSave(3 downto 0) = "0101" else --beq
                    '1' when InstructionSave(3 downto 0) = "0110" else --bge
                    '1' when InstructionSave(3 downto 0) = "0111" else --blt
                    '1' when InstructionSave(3 downto 0) = "1000" else --bne
                    '1' when InstructionSave(3 downto 0) = "1001" else --addi
                    '1' when InstructionSave(3 downto 0) = "1010" else --subi
                    '1' when InstructionSave(3 downto 0) = "1111" else --jump
                    '0';
    B_format_instruction <= Binstruction;
    
    Iinstruction <= '1' when InstructionSave(3 downto 0) = "1100" else -- lw
                    '1' when InstructionSave(3 downto 0) = "1011" else -- sw
                    '0';
    I_format_instruction <= Iinstruction;



    Rinstruction <= '1' when InstructionSave(3 downto 0) = "0001" else --add
                    '1' when InstructionSave(3 downto 0) = "0010" else --sub
                    '1' when InstructionSave(3 downto 0) = "0011" else --xor
                    '1' when InstructionSave(3 downto 0) = "0100" else --and
                    '0';
    R_format_instruction <= Rinstruction;

    ula_selector <= "00" when InstructionSave(3 downto 0) = "1001" else --addi
                    "00" when InstructionSave(3 downto 0) = "0001" else  --add
                    "01" when InstructionSave(3 downto 0) = "1010" else --subi
                    "01" when InstructionSave(3 downto 0) = "0010" else --sub
                    "10" when InstructionSave(3 downto 0) = "0011" else --xor
                    "10" when InstructionSave(3 downto 0) = "0100" else --and
                    "00";

    addressReg1 <= InstructionSave(6 downto 4);

    tmpImmI <= "1111111" when InstructionSave(15) = "1" else
               "0000000";
    tmpImmB <= "11111111111" when InstructionSave(15) = "1" else
                "0000000000";
                
    ula_input_Instruction <= tmpImmI&InstructionSave(15 downto 7) when Iinstruction = '1' else
                             tmpImmB"&InstructionSave(15 downto 10) when BInstruction = '1' else
                            x"0000";
end architecture;
