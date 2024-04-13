library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FullAdder8bits is
    port (
        A, B: in std_logic_vector(15 downto 0);
        Su: in std_logic;
        Result: out std_logic_vector(15 downto 0)
    );
end entity FullAdder8bits;

architecture behv of FullAdder8bits is
    signal C: std_logic_vector(16 downto 0) := (others => '0');
    signal CinxB: std_logic_vector(15 downto 0) := (others => '0');
    signal S: std_logic_vector(15 downto 0) := (others => '0');
begin

    aa:for i in 0 to 7 generate 
        CinxB(i) <= B(i) xor Su;
    end generate aa;

    C(0) <= Su;

    bb:for item in 0 to 15 generate 
        S(item) <= (std_logic(A(item)) xor CinxB(item)) xor C(item);
        C(item+1) <= (std_logic(A(item)) and CinxB(item)) or (C(item) and (std_logic(A(item)) xor CinxB(item)));
    end generate bb; 

    
    Result <= S;

end behv;