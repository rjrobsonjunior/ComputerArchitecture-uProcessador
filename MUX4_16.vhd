library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX4_16 is
    port (
        selector   : in unsigned (2 downto 0);
        inMUX      : in unsigned ( 127 downto 0); 
        outMUX     : out unsigned (15 downto 0) 
    );
end entity MUX4_16;

architecture rtl of MUX4_16 is

begin
    outMUX <= inMUX( 31 downto 16) when selector= "001" else
              inMUX( 47 downto 32) when selector= "010" else
              inMUX( 63 downto 48) when selector= "011" else
              inMUX( 79 downto 64) when selector= "100" else
              inMUX( 95 downto 80) when selector= "101" else
              inMUX( 111 downto 96) when selector=  "110" else
              inMUX( 127 downto 112) when selector= "111" else
              X"0000";

end architecture;
