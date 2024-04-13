library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ULA is
    port (
        selector   : in std_logic(1 dowto 0);
        inputA, inputB : in std_logic(15 downto 0);
        outResult : out std_logic(15 downto 0);
        carry, overflow : out std_logic   
    );
end entity ULA;

architecture rtl of ULA is



end architecture;