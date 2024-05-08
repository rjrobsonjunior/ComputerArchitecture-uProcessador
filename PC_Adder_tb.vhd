library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_Adder_tb is
end entity;

architecture impl of PC_Adder_tb is
    component PC_Adder is
        port(
            clk : in std_logic;

            jump_flag : in std_logic;
            jump_addr : in unsigned(6 downto 0);

            PC_reset : in std_logic;
            PC_wr_en : in std_logic;
            PC : out unsigned(6 downto 0)
        );
    end component;

    signal clk : std_logic;
    signal PC_reset : std_logic := '0';
    signal PC_wr_en : std_logic := '1';
    signal jump_flag : std_logic := '0';
    signal jump_addr : unsigned(6 downto 0);

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin

    PC_Adder_component : PC_Adder port map (
        clk => clk,
        jump_flag => jump_flag,
        jump_addr => jump_addr,
        PC_reset => PC_reset,
        PC_wr_en => PC_wr_en
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
