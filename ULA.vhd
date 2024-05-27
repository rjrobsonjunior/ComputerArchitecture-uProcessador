library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port (
        selector : in unsigned(1 downto 0);
        inputA, inputB : in unsigned(15 downto 0);
        outResult : out unsigned(15 downto 0);
        carry, overflow, bigger, smaller, zero, negative : out std_logic
    );
end entity ULA;

----------------------
------ selector------
-- 00 sum
-- 01 subtract
-- 10 xor
-- 11 and
----------------------

architecture ULA_arch of ULA is
-- x""
signal parcialResult :  unsigned (16 downto 0) := "00000000000000000";
signal sumResult : unsigned (16 downto 0) := "00000000000000000";
signal subResult : unsigned (16 downto 0) := "00000000000000000";
signal xorResult : unsigned (16 downto 0) := "00000000000000000";
signal andResult : unsigned (16 downto 0) := "00000000000000000";

begin

    sumResult <= ('0'&inputA) + ('0'&inputB);
    subResult <= ('0'&inputA) - ('0'&inputB);
    xorResult <= ('0'&inputA) xor ('0'&inputB);
    andResult <= ('0'&inputA) and ('0'&inputB);

    parcialResult <= sumResult when selector="00" else
                     subResult when selector="01" else
                     xorResult when selector="10" else
                     andResult when selector="11" else
                     "00000000000000000";

    bigger <= '1' when inputA > inputB else '0';

    smaller <= '1' when inputA < inputB else '0';
    
    zero <= '1' when parcialResult(15 downto 0) = x"0000" else '0';
    negative <= parcialResult(15);
    carry <= parcialResult(16);
    overflow <= parcialResult(16);
    outResult <= parcialResult(15 downto 0);
end ULA_arch;