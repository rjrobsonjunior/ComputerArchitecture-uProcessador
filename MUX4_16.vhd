library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX4_16 is
    port (
        selector   : in unsigned (3 downto 0);
        inMUX      : in unsigned ( 255 downto 0); 
        outMUX     : out unsigned (15 downto 0) 
    );
end entity MUX4_16;

architecture rtl of MUX4_16 is

begin
    outMUX <= inMUX( 15 downto 0) when selector= "0000" else
              inMUX( 31 downto 16) when selector= "0001" else
              inMUX( 47 downto 32) when selector= "0010" else
              inMUX( 63 downto 48) when selector= "0011" else
              inMUX( 79 downto 64) when selector= "0100" else
              inMUX( 95 downto 80) when selector= "0101" else
              inMUX( 111 downto 96) when selector=  "0110" else
              inMUX( 127 downto 112) when selector= "0111" else
              inMUX( 143 downto 128) when selector= "1000" else
              inMUX( 159 downto 144) when selector= "1001" else
              inMUX( 175 downto 160) when selector= "1010" else
              inMUX( 191 downto 176) when selector= "1011" else
              inMUX( 207 downto 192) when selector= "1100" else
              inMUX( 223 downto 208) when selector= "1101" else
              inMUX( 239 downto 224) when selector= "1110" else
              inMUX( 255 downto 240) when selector= "1111" else
              X"0000";
    

end architecture;