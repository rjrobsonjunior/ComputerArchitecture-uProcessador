library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX2_16 is
    port (
            input_signal : in std_logic;
            input0 : in unsigned(15 downto 0);
            input1 : in unsigned(15 downto 0);
            output : out unsigned(15 downto 0)
         );
end entity MUX2_16;


architecture impl of MUX2_16 is
begin
    output <= input0 when input_signal = '0' else
              input1 when input_signal = '1';
end architecture;
