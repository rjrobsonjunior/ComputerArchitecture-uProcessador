library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port (
        clk     : in std_logic;
        address : in unsigned(6 downto 0);
        data    : out unsigned(15 downto 0)
    );
end entity;

architecture rtl of ROM is

    type mem is array (0 to 127) of unsigned(15  downto 0);
    constant rom_data : mem := (
        0  => x"0000",
        1  => x"1111",
        2  => x"2222",
        3  => x"3333",
        4  => x"4444",
        5  => x"5555",
        6  => x"6666",
        7  => x"7777",
        8  => x"8888",
        9  => x"9999",
        10  => x"AAAA",
        11  => x"BBBB",
        12  => x"CCCC",
        13  => x"DDDD",
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
