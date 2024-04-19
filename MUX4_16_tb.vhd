library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX4_16_tb is
end entity MUX4_16_tb;

architecture rtl of MUX4_16_tb is

    component MUX4_16 is
        port (
            selector   : in unsigned (3 downto 0);
            inMUX      : in unsigned ( 255 downto 0); 
            outMUX     : out unsigned (15 downto 0) 
        );
    end component;
    
    signal selector_tb : unsigned (3 downto 0);
    signal inMUX_tb      : in unsigned ( 255 downto 0); 
    signal outMUX_tb     : out unsigned (15 downto 0);
    
begin
    mux : MUX4_16 port map (
        selector  => selector_tb,
        inMUX     => inMUX_tb,
        outMUX    => outMUX_tb
    );
    process 
    begin
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        
        wait for 50 ns;
        wait;
    end process;
    

end architecture;