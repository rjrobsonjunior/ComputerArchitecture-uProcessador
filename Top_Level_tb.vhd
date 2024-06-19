library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_Level_tb is
end entity;

architecture rtl of Top_Level_tb is

    component Top_Level is
        port(
            clk : in std_logic;
            PC_reset : in std_logic;
            data : out unsigned(15 downto 0);
            acc_out : out unsigned(15 downto 0)
        );
    end component;


    constant period_time : time := 10 ns;
    signal finished : std_logic := '0';

    signal rst : std_logic;
    signal clk : std_logic;
    signal data, acc_out : unsigned(15 downto 0);
    
begin
    uut: Top_Level port map(
        clk => clk,
        PC_reset => rst,
        data => data,
        acc_out => acc_out
    );

    rst_global: process
    begin
        wait;
    end process;
    

    sim_time_proc: process
    begin
        wait for 1000 us;
        finished <= '1';
        wait;
    end process sim_time_proc;


    clk_proc: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
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
        wait for period_time;

        wait for period_time;

        wait for period_time;

        wait for period_time;

        wait for period_time*6;

        wait;

    end process;

end architecture;
