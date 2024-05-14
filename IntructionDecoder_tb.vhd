library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IntructionDecoder_tb is
end entity IntructionDecoder_tb;

architecture rtl of IntructionDecoder_tb is

    component InstructionDecoder port (
        clk, clkFetch  : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        ula_selector : out unsigned(1 downto 0 );
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ula_input_Instruction : out unsigned( 15 downto 0) -- value form instruction type I and B, like addi, subi, be 
    );
    end component;

    signal clk, reset : std_logic;
    signal Binstruction, Iinstruction, Rinstruction : std_logic;
    signal ula_input_Instruction, instruction : unsigned(15 downto 0);
    signal ulaselector : unsigned(1 downto 0);
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
begin
    instructiondecodeComponent : InstructionDecoder port map (
        clk                   => clk,
        clkFetch              => '1',
        reset                 => reset,
        instruction           => instruction,
        ula_selector          => ulaselector,
        B_format_instruction  => Binstruction,
        I_format_instruction  => Iinstruction,
        R_format_instruction  => Rinstruction,
        ula_input_Instruction => ula_input_Instruction
    );
    
    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;


    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;


    process
    begin
        wait for period_time * 3;
        instruction <= b"000101_000_011_1001"; -- addi r3, zero, 5
        wait for period_time * 3;
        instruction <= b"000100_000_100_1001"; -- addi r4, zero, 4
        wait for period_time * 3;
        instruction <= b"000_100_011_101_0001"; -- add r5, r4, r3
        wait for period_time * 3;
        instruction <= b"000001_101_101_1010"; -- subi r5, r5, 1
        wait for period_time * 3;
        instruction <= b"010100_000_011_1111"; -- jump 0x14
        wait for period_time * 3;
        instruction <= b"000000_000_101_1001"; -- addi r5, zero, 0
        wait for period_time * 3;
        instruction <= b"000_011_000_101_0001"; -- add r5, zero, r3
        wait for period_time * 3;
        instruction <=  b"000010_000_011_1111"; -- jump 0x02
        wait for period_time * 3;
    wait;
end process;
end architecture;