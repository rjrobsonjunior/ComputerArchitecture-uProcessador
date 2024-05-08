library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_ROM_tb is
end entity;

architecture rtl of PC_ROM_tb is

    component Top_Level is
    port(
        clk : in std_logic;
        
        PC_reset : in std_logic;
        PC_wr_en : in std_logic;

        data: out unsigned(15 downto 0)
        );
    end component;

    signal PC_reset_s : std_logic := '0';
    signal PC_wr_en_s : std_logic := '0';

    signal clk : std_logic;
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin

    uut : Top_Level port map(
        clk => clk,
        PC_reset => PC_reset_s,
        PC_wr_en => PC_wr_en_s
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

        wait for period_time;

        wait for period_time;

        wait for period_time;

    wait;
end process;
end architecture;
