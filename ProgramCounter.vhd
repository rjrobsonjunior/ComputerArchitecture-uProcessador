library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProgramCounter is
    port (
        clk, reset, wren : in std_logic;
        datain: in unsigned (6 downto 0);
        counter: out unsigned(6 downto 0)
    );
end entity ProgramCounter;

architecture rtl of ProgramCounter is
    signal counterSignal : unsigned( 6 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counterSignal <= (others => '0');
        elsif rising_edge(clk) then
            if wren = '1' then
                counterSignal <= datain;
            end if;
        end if;
    end process;

    counter <= counterSignal;
    

end architecture;