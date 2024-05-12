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
        2  => b"000_100_011_101_0000", -- add r5, r4, r3
        3  => b"000001_101_101_1010", -- subi r5, r5, 1
        4  => b"010100_000_011_1111", -- jump 0x14
        5  => b"000000_000_101_1001", -- addi r5, zero, 0
        6  => x"F009", 
        7  => x"F005",
        8  => x"F007",
        9  => x"9999",
        10 => x"F000",
        11 => x"0000",
        12 => x"0000",
        13 => x"0000",
        14 => x"F009", 
        15 => x"F005",
        16 => x"F007",
        17 => x"9999",
        18 => x"F000",
        19 => x"0000",
        20 => b"000_011_000_101_0000", -- add r5, zero, r3
        21 => b"000010_000_011_1111", -- jump 0x02
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
