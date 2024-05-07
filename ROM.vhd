library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port (
        clk     : in std_logic;
        address  : in unsigned(6 downto 0);
        data    : out unsigned(11 downto 0)
    );
end entity;

architecture rtl of ROM is
    type mem is array (0 to 127) of unsigned(11  downto 0);
    constant rom_data : mem := (
        0 => "000000000000",
        1 => "000000000010",
        2 => "000000000100",
        3 => "000000000100",
        4 => "000000000100",
        5 => "000000000100",
        6 => "000000000100",
        7 => "000000000100",
        8 => "000000011111",
        9 => "111000000100",
        10 => "000000001100",
        11 => "000001001110",
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
