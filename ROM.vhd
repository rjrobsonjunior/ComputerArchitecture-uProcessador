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
        1  => x"F003",
        2  => x"2222",
        3  => x"3333",
        4  => x"F008",
        5  => x"5555",
        6  => x"F009",
        7  => x"F005",
        8  => x"F007",
        9  => x"9999",
        10 => x"F000",
        11 => x"0000",
        12 => x"0000",
        13 => x"0000",
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
