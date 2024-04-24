library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterBank_tb is
end entity RegisterBank_tb;

architecture impl of RegisterBank_tb is
    component RegisterBank
        port( address1      : in unsigned(2 downto 0);
              address2      : in unsigned(2 downto 0);
              writeRegister : in unsigned(2 downto 0);
              datawr        : in unsigned(15 downto 0);
              wren          : in std_logic;
              clk           : in std_logic;
              rst           : in std_logic;
              data1         : out unsigned(15 downto 0);
              data2         : out unsigned(15 downto 0);
              outEightRegistersSignal : out unsigned ( 127 downto 0)
            );
    end component;

    signal address1, address2 : unsigned(2 downto 0);
    signal writeRegister      : unsigned(2 downto 0);
    signal datawr             : unsigned(15 downto 0);
    signal wren, clk, rst     : std_logic;
    signal data1, data2       : unsigned(15 downto 0);
    signal outEightRegistersSignal : unsigned(127 downto 0);
    constant period_time      : time := 100 ns;
    signal finished           : std_logic := '0';

begin
    uut: RegisterBank port map( address1      => address1,
                                address2      => address2,
                                writeRegister => writeRegister,
                                datawr        => datawr,
                                wren          => wren,
                                clk           => clk,
                                rst           => rst,
                                data1         => data1,
                                data2         => data2,
                                outEightRegistersSignal => outEightRegistersSignal 
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
        wait for 200 ns;
        wren <= '1';
        writeRegister <= "001";
        datawr <= X"6969";
        address1 <= "001";
        address2 <= "000";

        wait for 200 ns;
        wren <= '1';
        writeRegister <= "011";
        datawr <= X"2469";
        address1 <= "001";
        address2 <= "011";

        wait for 100 ns;
        wren <= '0';
        address1 <= "001";
        address2 <= "011";

        wait for 100 ns;
        wren <= '0';
        address1 <= "011";
        address2 <= "001";

        wait for 100 ns;
        wren <= '0';
        writeRegister <= "010";
        datawr <= X"4200";
        wren <= '1';

        wait for 100 ns;
        wren <= '0';
        address1 <= "010";
        address2 <= "000";

        wait for 200 ns;
        wren <= '1';
        writeRegister <= "111";
        datawr <= X"2469";
        address1 <= "001";
        address2 <= "011";

        wait for 100 ns;
        wren <= '0';
        address1 <= "010";
        address2 <= "111";
        wait for 100 ns;
        wren <= '0';
        address1 <= "001";
        address2 <= "111";
        wait for 100 ns;
        wren <= '0';

        wait;

    end process;

end impl;
