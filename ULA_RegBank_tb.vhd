library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_RegBank_tb is
end entity ULA_RegBank_tb;

architecture impl of ULA_RegBank_tb is
    component ULA_RegBank is
        port (
            clk, rst, wr_en : in std_logic;
            mux_selector    : in std_logic;

            rb_address1     : in unsigned(2 downto 0);
            rb_address2     : in unsigned(2 downto 0);
            rb_wr_reg       : in unsigned(2 downto 0);

            ula_mux_input   : in unsigned(15 downto 0);
            ula_selector    : in unsigned(1 downto 0);
            ula_carry       : out std_logic;
            ula_overflow    : out std_logic;
            ula_bigger      : out std_logic;
            ula_smaller     : out std_logic;
            ula_output      : out unsigned(15 downto 0)
    );

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

    signal clk           : std_logic;
    signal rst           : std_logic;
    signal wr_en         : std_logic;
    signal mux_selector  : std_logic;

    signal rb_address1   : unsigned(2 downto 0);
    signal rb_address2   : unsigned(2 downto 0);
    signal rb_wr_reg     : unsigned(2 downto 0);

    signal ula_mux_input : unsigned(15 downto 0);
    signal ula_selector  : unsigned(1 downto 0);
    signal ula_carry     : std_logic;
    signal ula_overflow  : std_logic;
    signal ula_bigger    : std_logic;
    signal ula_smaller   : std_logic;
    signal ula_output    : unsigned(15 downto 0);

begin
    ULA_RegBank_component: ULA_RegBank
    port map (
                 clk           => clk,
                 rst           => rst,
                 wr_en         => wr_en,
                 mux_selector  => mux_selector,
                 rb_address1   => rb_address1,
                 rb_address2   => rb_address2   
                 rb_wr_reg     => rb_wr_reg,
                 ula_mux_input => ula_mux_input,
                 ula_selector  => ula_selector,
                 ula_carry     => ula_carry,
                 ula_overflow  => ula_overflow,
                 ula_bigger    => ula_bigger,
                 ula_smaller   => ula_smaller,
                 ula_output    => ula_output
             );


    rst_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    

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
        

        wait for 100 ns;

        wait for 100 ns;

        wait for 100 ns;

        wait for 100 ns;

        wait for 100 ns;

        wait for 100 ns;


        wait;
    end process;

end architecture impl;
