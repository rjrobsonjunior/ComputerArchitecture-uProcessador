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

    -- carrega na memóra até o valor e endereço definido no cmp linha 6, estável
    0  => b"000000001_111_1000", -- ld r7, 1   (A) x"0038"
    1  => b"000000000_001_1000", -- ld r1, 0   (A) x"0018"
    2  => b"000000000_001_1101", -- movA r1    (A) x"001D"
    3  => b"000000000_111_0001", -- add r7     (A) x"003D"
    4  => b"000000000_001_1110", -- movR r1    (A) x"001E"
    5  => b"000000000_001_1100", -- sw r1      (A) x"001B"
    6  => b"000000001000_0111",  -- cmp 16     (A) x"003D"
    7 =>  b"111111111011_0101",   -- jz -4     (A) x"FF95"

    -- r1 é usado para varrer de 2 a raiz do numero maximo e r2 armazenado os multiplos de r1
    8  => b"000000001_001_1000", -- ld r1, 2
    9  => b"000000000_001_1101", -- movA r1    (A) x"001D"
    10 => b"000000000_001_0001", -- add r1     (A) x"0011"
    11 => b"000000000_010_1110", -- movR r2    (A) x"002E"
    12 => b"000000000_000_1101", -- movA r0    (A) x"000D"
    13 => b"000000000_010_1100", -- sw r2      (A) x"002B"
    14 => b"000000000_010_1101", -- movA r2    (A) x"002D"
    15 => b"000000001000_0111",  -- cmp 16     (A) x"003D"
    16 => b"111111110101_1011",  --  jz -6
    17 => b"000000000_001_1101", -- movA r1    (A) x"001D"
    18 => b"000000000100_0111",  -- cmp 4      (A) x"003D"
    19 => b"000000000101_0101",  --  jz 5

    -- itera r1
    23 => b"000000101000_1111", -- jump 40
    24 => b"000000000_001_1101", -- movA r1    (A) x"001D"
    25 => b"000000000_111_0001", -- add r7     (A) x"0011"                               -- add r1
    26 => b"000000000_001_1110", -- movR r1    (A) x"001E"                          --movR r1
    27 => b"000000001010_1111",  -- jump 10

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
