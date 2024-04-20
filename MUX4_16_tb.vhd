library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX4_16_tb is
end entity MUX4_16_tb;

architecture rtl of MUX4_16_tb is

    component MUX4_16 is
        port (
            selector   : in unsigned (2 downto 0);
        inMUX      : in unsigned ( 127 downto 0); 
        outMUX     : out unsigned (15 downto 0) 
        );
    end component;
    
    signal selector_tb : unsigned (2 downto 0);
    signal inMUX_tb : unsigned ( 127 downto 0); 
    signal outMUX_tb : unsigned (15 downto 0);

begin
    mux : MUX4_16 port map (
        selector  => selector_tb,
        inMUX     => inMUX_tb,
        outMUX    => outMUX_tb
    );
    process 
    begin
        selector_tb <= "000";
        inMUX_tb <= x"0123456789ABCDEF0123456789ABCDEF";
        wait for 50 ns;
        selector_tb <= "001";
        wait for 50 ns;
        selector_tb <= "010";
        wait for 50 ns;
        selector_tb <= "100";
        wait for 50 ns;
        selector_tb <= "110";
        wait for 50 ns;
        selector_tb <= "111";
        wait;
    end process;
    

end architecture;