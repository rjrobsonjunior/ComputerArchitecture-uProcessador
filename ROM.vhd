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

    0  => b"000000001_111_1000", -- ld r7, 1   (A) x"0038"
    1  => b"000000000_001_1000", -- ld r1, 0   (A) x"0018"
    2  => b"000000000_001_1101", -- movA r1    (A) x"001D"
    3  => b"000000000_111_0001", -- add r7     (A) x"003D"
    4  => b"000000000_001_1110", -- movR r1    (A) x"001E"
    5  => b"000000000_001_1100", -- sw r1      (A) x"001B"
    6  => b"010000000000_0111",  -- cmp 1024   (A) x"003D"
    7 =>  b"111111111011_0101",   -- jz -4     (A) x"FF95"

    8  => b"000000001_001_1000", -- ld r1, 1
    9  => b"000000000_001_1101", -- movA r1    (A) x"001D"
    10 => b"000000000_111_0001", -- add r7     (A) x"003D"
    11 => b"000000000_001_0001",  -- add r1    (A) x"0011"
    12 => b"000000000_010_1110", -- movR r2    (A) x"002E"
    13 => b"000000000_000_1101", -- movA r0    (A) x"000D"
    14  => b"000000000_010_1100", -- sw r2      (A) x"002B"
    15  => b"010000000000_0111",  -- cmp 1024   (A) x"003D"
    16 => b"111111111001_0101",   --  jz -7
    17 => b"000000100000_0111",  -- cmp 32   (A) x"003D"
    18 => b"111111110111_0101",  --  jz -9

    -- 8  => b"000000000_101_0001", -- add r5     (D) x"00D9"
    -- 9  => b"000000000_011_1110", -- movR r3    (D) x"003E"
    -- 10  => b"000000011110_0111",  -- cmp 30    (E) x"01E7"
    -- 11 => b"111111111001_0101",  -- jz -7      (E) x"FD05"
    -- 12 => b"000000000_100_1101", -- movA r4    (F) x"004D"
    -- 13 => b"000000000_101_1110", -- movR r5    (F) x"005E"

    
    
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
