library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProgramCounter_tb is
end entity;

architecture impl of ProgramCounter_tb is
    component ControlUnit is
        port(
            clk   : in std_logic;
            instruction : in unsigned(13 downto 0);
            PCclock, ROMclock : out std_logic;
            jump : out std_logic;
            
            PC_reset : in std_logic;
            PC : out unsigned(6 downto 0)
            );
    end component;

    signal clk, PC_reset : std_logic;
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

    signal instruction : unsigned(13 downto 0) := (others => '0');
    signal PCclock, ROMclock: std_logic := '0';
begin

    ControlUnit_component : ControlUnit port map (
        clk => clk,
        instruction => instruction,
        PCclock => PCclock,
        ROMclock => ROMclock,
        PC_reset => PC_reset
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
        wait for period_time * 2;



        wait for period_time;

        wait for period_time;

        wait for period_time;
        PC_reset <= '1';

        wait for period_time;
        PC_reset <= '0';

        wait for period_time;

        wait for period_time;

        wait;
    end process;

end architecture;
