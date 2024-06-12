library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX2BITS is
    port (
            input_signal : in unsigned(1 downto 0);
            input0 : in  unsigned(15 downto 0);
            input1 : in  unsigned(15 downto 0);
            input2 : in  unsigned(15 downto 0);
            output : out unsigned(15 downto 0)
         );
end entity MUX2BITS ;


architecture impl of MUX2BITS  is
begin
    output <= input0 when input_signal = "00" else
              input1 when input_signal = "01" else
              input2 when input_signal = "10";
end architecture;
