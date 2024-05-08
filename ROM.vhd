library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port (
        clk     : in std_logic;
        address : in unsigned(6 downto 0);
        data    : out unsigned(13 downto 0)
    );
end entity;

architecture rtl of ROM is

    type mem is array (0 to 127) of unsigned(13  downto 0);
    constant rom_data : mem := (
        0  => "00000000000010", --0002
        1  => "00100000000000", --0800
        2  => "00000000000000", --0000
        3  => "11110000101000", --0000
        4  => "11010000000000", --3C00
        5  => "00000000000010", --0002
        6  => "11110001000011", --0F03
        7  => "00000000000010", --0002
        8  => "11110000110011", --0002
        9  => "00000000000000", --0000
        10 => "00000000000000", --0000
        11 => "00000010010110",
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data <= rom_data(to_integer(address));
        end if;
    end process;

end architecture;
