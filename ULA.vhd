library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port (
        selector : in unsigned(1 downto 0);
        inputA, inputB : in unsigned(15 downto 0);
        outResult : out unsigned(15 downto 0);
        carry, overflow, bigger, smaller : out unsigned(0 downto 0) 
    );
end entity ULA;

architecture ULA_arch of ULA is

signal parcialResult :  unsigned (16 downto 0) := "00000000000000000";
signal sumResult : unsigned (16 downto 0) := "00000000000000000";
signal subResult : unsigned (16 downto 0) := "00000000000000000";
signal xorResult : unsigned (16 downto 0) := "00000000000000000";
signal andResult : unsigned (16 downto 0) := "00000000000000000";

begin

    sumResult <= inputA + inputB;
    subResult <= inputA - inputB;
    xorResult <= inputA xor inputB;
    andResult <= inputA and inputB;

    parcialResult <= sumResult when selector="00" else
                     subResult when selector="01" else
                     xorResult when selector="10" else
                     andResult when selector="11" else
                     "00000000000000000";

    carry <= parcialResult(16 downto 16);
    overflow <= parcialResult(16 downto 16);
    outResult <= parcialResult(15 downto 0);
end ULA_arch;