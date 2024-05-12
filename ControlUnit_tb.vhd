library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit_tb is
end entity ControlUnit_tb;

architecture rtl of ControlUnit_tb is

    component ControlUnit is
        port (
            clk   : in std_logic;
            instruction : in unsigned(15 downto 0);
            jump : out std_logic;
            jump_addr : out unsigned(6 downto 0);
            fetchState, decodeState, executeState  : out std_logic
        );
    end component;



    signal clk : std_logic;
    signal instruction : unsigned(15 downto 0);
    signal jump : std_logic;
    signal jump_addr : unsigned(6 downto 0);
    signal fetchState, decodeState, executeState : std_logic;

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
begin
    controlcomponent: ControlUnit port map (
        clk          => clk,
        instruction  => instruction,
        jump         => jump,
        jump_addr    => jump_addr,
        fetchState   => fetchState,
        decodeState  => decodeState,
        executeState => executeState 
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
        instruction <= b"000_100_011_101_0000"; -- add r5, r4, r3
        wait for period_time * 3;
        instruction <= b"000001_101_101_1010"; -- subi r5, r5, 1
        wait for period_time * 3;
        instruction <= b"010100_000_011_1111"; -- jump 0x14
        wait for period_time * 3;
        instruction <= b"000000_000_101_1001"; -- addi r5, zero, 0
        wait for period_time * 3;
        instruction <= b"000_011_000_101_0000"; -- add r5, zero, r3
        wait for period_time * 3;
        instruction <=  b"000010_000_011_1111"; -- jump 0x02
        wait for period_time * 3;
    wait;
end process;

end architecture;