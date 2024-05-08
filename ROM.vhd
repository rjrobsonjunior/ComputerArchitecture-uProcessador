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
        0  => x"FFFF",
        1  => x"0000",
        2  => x"FFFF",
        3  => x"0000",
        4  => x"FFFF",
        5  => x"0000",
        6  => x"FFFF",
        7  => x"0000",
        8  => x"FFFF",
        9  => x"0000",
        10  => x"FFFF",
        11  => x"0000",
        12  => x"FFFF",
        13  => x"0000",
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
