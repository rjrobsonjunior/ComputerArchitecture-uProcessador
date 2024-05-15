library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionRegister_tb is
end entity InstructionRegister_tb;

architecture rtl of InstructionRegister_tb is

    component InstructionRegister port (
        clk, clkFetch  : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        ula_selector : out unsigned(1 downto 0 );
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ImmValue : out unsigned( 15 downto 0);  
        addressReg1, addressReg2: out unsigned( 2 downto 0)
        );
    end component;

    signal clk, reset : std_logic;
    signal Binstruction, Iinstruction, Rinstruction : std_logic;
    signal ImmValue, instruction : unsigned(15 downto 0);
    signal ulaselector : unsigned(1 downto 0);
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
begin
    instructiondecodeComponent : InstructionRegister port map (
        clk                   => clk,
        clkFetch              => '1',
        reset                 => reset,
        instruction           => instruction,
        ula_selector          => ulaselector,
        B_format_instruction  => Binstruction,
        I_format_instruction  => Iinstruction,
        R_format_instruction  => Rinstruction,
        ImmValue => ImmValue
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
        instruction <= b"000101000_011_1000"; -- ld r3, 5   (A)
        wait for period_time * 3;
        instruction <= b"000100000_100_1000"; -- ld r4, 8   (B)
        wait for period_time * 3;
        instruction <= b"000000000_011_1101"; -- movA r3    (C)
        wait for period_time * 3;
        instruction <= b"000000000_100_0001"; -- add r4     (C)
        wait for period_time * 3;
        instruction <= b"000000000_101_1110"; -- movR r5    (C)
        wait for period_time * 3;
        instruction <= b"111111110_101_1001"; -- addi -1    (D)
        wait for period_time * 3;
        instruction <= b"000000000_101_1110"; -- movR r5    (D)
        wait for period_time * 3;
        instruction <=  b"010100_000_000_1111"; -- jump 0x14 (E)
        wait for period_time * 3;
        instruction <=  b"000000_000_101_1000"; -- ld r5, 0  (F)
        wait for period_time * 3;
        instruction <=  b"000000000_011_1101"; -- movA r5    (G)
        wait for period_time * 3;
        instruction <=  b"000000000_011_1110"; -- movR r3    (G)
        wait for period_time * 3;
        instruction <=  b"000010_000_011_1111"; -- jump 0x02 (H)
        wait for period_time * 3;

    wait;
end process;
end architecture;