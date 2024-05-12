library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine_tb is
end entity;


architecture impl of stateMachine_tb is

    component stateMachine is
        port (
        clk      : in std_logic;
        rst      : in std_logic;
        state : out unsigned( 1 downto 0)
        );
    end component;

    signal clk, rst: std_logic;
    signal state : unsigned (1 downto 0);

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin
    stateMachineComponent : stateMachine port map (
        rst => rst,
        clk => clk,
        state => state
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
        rst <= '0';
        wait for period_time * 2;

        wait for period_time;
        rst <= '1';

        wait for period_time;
        rst <= '0';

        wait for period_time;

        wait for period_time;

        wait for period_time;

        wait;
    end process;


end architecture;
