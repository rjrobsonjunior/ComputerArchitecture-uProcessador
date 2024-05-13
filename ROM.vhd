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
        0  => b"000101_000_011_1001", -- addi r3, zero, 5
        1  => b"000100_000_100_1001", -- addi r4, zero, 4
        2  => b"000000_100_101_1001", -- add r5, r4
        3  => b"000000_011_101_0001", -- add r5, r3
        4  => b"000001_101_101_1010", -- subi r5, r5, 1
        5  => b"010100_000_011_1111", -- jump 0x14
        6  => b"000000_000_101_1001", -- addi r5, zero, 0
        7  => x"F009", 
        8  => x"F005",
        9  => x"F007",
        10  => x"9999",
        11 => x"F000",
        12 => x"0000",
        13 => x"0000",
        14 => x"0000",
        15 => x"F009", 
        16 => x"F005",
        17 => x"F007",
        18 => x"9999",
        19 => x"F000",
        20 => x"0000",
        21 => b"000000_011_101_0001", -- add r5, r3
        22 => b"000010_000_011_1111", -- jump 0x02
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
