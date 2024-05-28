library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionRegister is
    port (
        clk, clkFetch  : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ImmValue : out unsigned( 15 downto 0);  
        addressReg1: out unsigned( 2 downto 0)
        );
end entity InstructionRegister;

architecture rtl of InstructionRegister is
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
signal tmpImmB : unsigned (3 downto 0);
begin
    componentInstruction : reg16bits port map (
        clk      => clk,
        rst      => reset,
        wr_en    => clkFetch,
        data_in  => instruction,
        data_out => InstructionSave
    );
    ----------------------- 
    Binstruction <= '1' when InstructionSave(3 downto 0) = "0101" else --jz
                    '1' when InstructionSave(3 downto 0) = "0110" else --jc
                    '1' when InstructionSave(3 downto 0) = "0111" else --cmp
                    '1' when InstructionSave(3 downto 0) = "1111" else --jump
                    '0';
    B_format_instruction <= Binstruction;
    
    Iinstruction <= '1' when InstructionSave(3 downto 0) = "1010" else -- sw
                    '1' when InstructionSave(3 downto 0) = "1011" else -- lw
                    '1' when InstructionSave(3 downto 0) = "1001" else -- addi
                    '1' when InstructionSave(3 downto 0) = "1000" else -- ld
                    '0';
    I_format_instruction <= Iinstruction;



    Rinstruction <= '1' when InstructionSave(3 downto 0) = "0001" else --add
                    '1' when InstructionSave(3 downto 0) = "0010" else --sub
                    '1' when InstructionSave(3 downto 0) = "0011" else --xor
                    '1' when InstructionSave(3 downto 0) = "0100" else --and
                    '1' when InstructionSave(3 downto 0) = "1101" else --movA
                    '1' when InstructionSave(3 downto 0) = "1110" else --movR
                    '0';
    R_format_instruction <= Rinstruction;

    addressReg1 <= InstructionSave(6 downto 4);
    
    tmpImmI <= "1111111" when InstructionSave(15) = '1' else
               "0000000";
    tmpImmB <= "1111" when InstructionSave(15) = '1' else
               "0000";

    ImmValue <= tmpImmI&InstructionSave(15 downto 7) when Iinstruction = '1' else
                tmpImmB&InstructionSave(15 downto 4) when BInstruction = '1' else 
                x"0000";
                            
end architecture;
