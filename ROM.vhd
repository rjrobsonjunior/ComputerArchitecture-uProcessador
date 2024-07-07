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

    -------------------------------------------------------------------------------
    ------------------------------- primes up to 16 -------------------------------
    -------------------------------------------------------------------------------

    -- -- carrega na memóra até o valor e endereço definido no cmp linha 6, estável
    -- 0  => b"000000001_111_1000", -- ld r7, 1   (A) x"0038"
    -- 1  => b"000000000_001_1000", -- ld r1, 0   (A) x"0018"
    -- 2  => b"000000000_001_1101", -- movA r1    (A) x"001D"
    -- 3  => b"000000000_111_0001", -- add r7     (A) x"003D"
    -- 4  => b"000000000_001_1110", -- movR r1    (A) x"001E"
    -- 5  => b"000000000_001_1100", -- sw r1      (A) x"001B"
    -- 6  => b"000000010000_0111",  -- cmp 16     (A) x"003D"
    -- 7  => b"000000000010_0101",  -- jz +2     (A) x"FF95"
    -- 8  => b"000000000010_1111",  -- jump 2     (A) x"FF95"
    --
    -- -- r1 é usado para varrer de 2 a raiz do numero maximo e r2 armazenado os multiplos de r1
    --
    -- -- inicializa o iterador
    -- 9  => b"000000010_001_1000", -- ld r1, 2
    --
    -- -- checa condicao
    -- -- BEGIN
    -- 10 => b"000000000_001_1101", -- movA r1    (A) x"001D"
    -- 11 => b"000000000101_0111",  -- cmp 5      (A) x"003D"
    -- 12 => b"000000010101_0101",  --  jz 21
    --
    -- 13 => b"000000000_001_1101", -- movA r1
    -- 14 => b"000000000_010_1110", -- movR r2
    -- -- main loop
    -- -- LOOP
    -- 15 => b"000000000_010_1101", -- movA r2    (A) x"001D"
    -- 16 => b"000000000_001_0001", -- add r1     (A) x"0011"
    -- 17 => b"000000000_010_1110", -- movR r2    (A) x"002E"
    -- 18 => b"000000000_000_1101", -- movA r0    (A) x"000D"
    -- 19 => b"000000000_010_1100", -- sw r2      (A) x"002B"
    -- 20 => b"000000000_010_1101", -- movA r2    (A) x"002D"
    -- 21 => b"000000010000_0111",  -- cmp 16     (A) x"003D"
    -- 22 => b"000000000011_0101",  -- jz 3
    -- 23 => b"000000000010_1010",  -- jn 2
    -- 24 => b"000000001111_1111",  -- jump 15 (LOOP)
    --
    -- -- encontra prox. r1
    -- 25 => b"000000000_001_1101", -- movA r1
    -- 26 => b"000000000_111_0001", -- add r7
    -- 27 => b"000000000_001_1110", -- movR r1
    -- 28 => b"000000000_001_1011", -- lw r1
    -- 29 => b"000000000000_0111",  -- cmp 0
    -- 30 => b"111111111011_0101",  -- jz -5
    -- 31 => b"000000001010_1111",  -- jump 10 (BEGIN)
    --
    --
    -- ----------------------
    -- -- mostra os primos --
    -- ----------------------
    --
    -- -- inicializa o iterador
    -- 33 => b"000000010_001_1000", -- ld r1, 2
    -- 
    -- -- checa condicao
    -- -- LOOP2
    -- 34 => b"000000000_001_1101", -- movA r1
    -- 35 => b"000000010000_0111",  -- cmp 16
    -- 36 => b"000000100000_0101",  -- jz +32
    --
    -- -- mostra o primo em r4
    -- 37 => b"000000000_001_1011", -- lw r1
    -- 38 => b"000000000000_0111",  -- cmp 0
    -- 39 => b"000000000010_0101",  -- jz +2
    -- 40 => b"000000000_100_1110", -- movR r4
    --
    -- -- soma o iterador
    -- 41 => b"000000000_001_1101", -- movA r1
    -- 42 => b"000000000_111_0001", -- add r7
    -- 43 => b"000000000_001_1110", -- movR r1
    -- 44 => b"000000100010_1111",  -- jump 34 (LOOP2)

    -------------------------------------------------------------------------------


    -------------------------------------------------------------------------------
    -------------------------------- is 7374 prime? -------------------------------
    -------------------------------------------------------------------------------

    -- -- carrega na memóra até o valor e endereço definido no cmp linha 6, estável
    -- 0  => b"000000001_111_1000", -- ld r7, 1   (A) x"0038"
    --
    -- -- Load r6 with 2047
    -- 1  => b"011111111_110_1000", -- ld r6, 255
    -- 2  => b"000000000_110_1101", -- movA r6
    -- 3  => b"000000000_111_0001", -- add r7
    -- 4  => b"000000000_110_1110", -- movR r6
    -- 5  => b"000000000_110_0001", -- add r6
    -- 6  => b"000000000_110_0001", -- add r6
    -- 7  => b"000000000_110_0001", -- add r6
    -- 8  => b"000000000_110_0001", -- add r6
    -- 9  => b"000000000_110_0001", -- add r6
    -- 10 => b"000000000_110_0001", -- add r6
    -- 11 => b"000000000_110_0001", -- add r6
    -- 12 => b"000000000_111_0010", -- sub r7
    -- 13 => b"000000000_110_1110", -- movR r6
    --
    -- 14  => b"000000000_001_1000", -- ld r1, 0   (A) x"0018"
    -- 15  => b"000000000_001_1101", -- movA r1    (A) x"001D"
    -- 16  => b"000000000_111_0001", -- add r7     (A) x"003D"
    -- 17  => b"000000000_001_1110", -- movR r1    (A) x"001E"
    -- 18  => b"000000000_001_1100", -- sw r1      (A) x"001B"
    -- -- 6  => b"000000010000_0111",  -- cmp 16     (A) x"003D"
    -- -- 7  => b"000000000010_0101",  -- jz +2     (A) x"FF95"
    -- -- 8  => b"000000000010_1111",  -- jump 2     (A) x"FF95"
    --
    --
    -- -----------------------------------------------------------
    -- ---------------- check if at upper limit ------------------
    -- -----------------------------------------------------------
    --
    -- 20 => b"011111111111_0111",  -- cmp 2047
    -- 21 => b"000000000010_1010",  -- jn +2
    -- 22 => b"000000001111_1111",  -- jump 15
    --
    -- 23 => b"000000000_110_0010", -- sub r6
    -- 24 => b"011111111111_0111",  -- cmp 2047
    -- 25 => b"000000000010_1010",  -- jn +2
    -- 26 => b"000000001111_1111",  -- jump 15
    --
    -- 27 => b"000000000_110_0010", -- sub r6
    -- 28 => b"011111111111_0111",  -- cmp 2047
    -- 29 => b"000000000010_1010",  -- jn +2
    -- 30 => b"000000001111_1111",  -- jump 15
    --
    -- 31 => b"000000000_110_0010", -- sub r6
    -- 32 => b"010011011011_0111",  -- cmp 1243
    -- 33 => b"000000000011_0101",  -- jz +2
    -- 34 => b"000000001111_1111",  -- jump 15
    --
    -- ------------------------------------------------------------
    --
    --
    -- -- r1 é usado para varrer de 2 a raiz do numero maximo e r2 armazenado os multiplos de r1
    --
    -- -- inicializa o iterador
    -- 36  => b"000000010_001_1000", -- ld r1, 2
    --
    -- -- checa condicao
    -- -- BEGIN
    -- 37 => b"000000000_001_1101", -- movA r1    (A) x"001D"
    -- 38 => b"000001010101_0111",  -- cmp 85      (A) x"003D"
    -- 39 => b"000000100001_0101",  --  jz +33
    -- 40 => b"000000100010_1010",  --  jn +34
    --
    -- 41 => b"000000000_001_1101", -- movA r1
    -- 42 => b"000000000_010_1110", -- movR r2
    -- -- main loop
    -- -- LOOP
    -- 43 => b"000000000_010_1101", -- movA r2    (A) x"001D"
    -- 44 => b"000000000_001_0001", -- add r1     (A) x"0011"
    -- 45 => b"000000000_010_1110", -- movR r2    (A) x"002E"
    -- 46 => b"000000000_000_1101", -- movA r0    (A) x"000D"
    -- 47 => b"000000000_010_1100", -- sw r2      (A) x"002B"
    -- 48 => b"000000000_010_1101", -- movA r2    (A) x"002D"
    --
    -- -- 21 => b"000000010000_0111",  -- cmp 16     (A) x"003D"
    -- -- 22 => b"000000000011_0101",  -- jz 3
    -- -- 23 => b"000000000010_1010",  -- jn 2
    -- -- 24 => b"000000001111_1111",  -- jump 15 (LOOP)
    --
    -- -----------------------------------------------------------
    -- ---------------- check if at upper limit ------------------
    -- -----------------------------------------------------------
    --
    -- 50 => b"011111111111_0111",  -- cmp 2047
    -- 51 => b"000000000010_1010",  -- jn +2
    -- 52 => b"000000101011_1111",  -- jump 43 (LOOP)
    --
    -- 53 => b"000000000_110_0010", -- sub r6
    -- 54 => b"011111111111_0111",  -- cmp 2047
    -- 55 => b"000000000010_1010",  -- jn +2
    -- 56 => b"000000101011_1111",  -- jump 43 (LOOP)
    --
    -- 57 => b"000000000_110_0010", -- sub r6
    -- 58 => b"011111111111_0111",  -- cmp 2047
    -- 59 => b"000000000010_1010",  -- jn +2
    -- 60 => b"000000101011_1111",  -- jump 43 (LOOP)
    --
    -- 61 => b"000000000_110_0010", -- sub r6
    -- 62 => b"010011011011_0111",  -- cmp 1243
    -- 63 => b"000000000011_0101",  -- jz +3
    -- 64 => b"000000000010_1010",  -- jn +2
    -- 65 => b"000000101011_1111",  -- jump 43 (LOOP)
    --
    -- ------------------------------------------------------------
    --
    -- -- encontra prox. r1
    -- 66 => b"000000000_001_1101", -- movA r1
    -- 67 => b"000000000_111_0001", -- add r7
    -- 68 => b"000000000_001_1110", -- movR r1
    -- 69 => b"000000000_001_1011", -- lw r1
    -- 70 => b"000000000000_0111",  -- cmp 0
    -- 71 => b"111111111011_0101",  -- jz -5
    -- 72 => b"000000100101_1111",  -- jump 37 (BEGIN)
    --
    --
    -- ----------------------
    -- -- mostra os primos --
    -- ----------------------
    --
    -- -- inicializa o iterador
    -- 74 => b"000000010_001_1000", -- ld r1, 2
    -- 
    -- -- checa condicao
    -- -- LOOP2
    -- 75 => b"000000000_001_1101", -- movA r1
    -- -- 70 => b"000000010000_0111",  -- cmp 16
    -- -- 71 => b"000000100000_0101",  -- jz +32
    --
    -- -----------------------------------------------------------
    -- ---------------- check if at upper limit ------------------
    -- -----------------------------------------------------------
    --
    -- 77 => b"011111111111_0111",  -- cmp 2047
    -- 78 => b"000000000010_1010",  -- jn +2
    -- 79 => b"000001100101_1111",  -- jump 101
    --
    -- 80 => b"000000000_110_0010", -- sub r6
    -- 81 => b"011111111111_0111",  -- cmp 2047
    -- 82 => b"000000000010_1010",  -- jn +2
    -- 83 => b"000001100101_1111",  -- jump 101
    --
    -- 84 => b"000000000_110_0010", -- sub r6
    -- 85 => b"011111111111_0111",  -- cmp 2047
    -- 86 => b"000000000010_1010",  -- jn +2
    -- 87 => b"000001100101_1111",  -- jump 101
    --
    -- 88 => b"000000000_110_0010", -- sub r6
    -- 89 => b"010011011011_0111",  -- cmp 1243
    -- 90 => b"000000100000_0101",  -- jz +32
    -- 91 => b"000001100101_1111",  -- jump 101
    --
    -- ------------------------------------------------------------
    --
    -- -- mostra o primo em r4
    -- 101 => b"000000000_001_1011", -- lw r1
    -- 102 => b"000000000000_0111",  -- cmp 0
    -- 103 => b"000000000010_0101",  -- jz +2
    -- 104 => b"000000000_100_1110", -- movR r4
    --
    -- -- soma o iterador
    -- 105 => b"000000000_001_1101", -- movA r1
    -- 106 => b"000000000_111_0001", -- add r7
    -- 107 => b"000000000_001_1110", -- movR r1
    -- 108 => b"000001001011_1111",  -- jump 75 (LOOP2)


    1  => b"100000000_001_1000", -- ld r1, 100000000
    2  => b"000000000_001_1101", -- movA r1
    3  => b"000000000_001_0001", -- add r1
    4  => b"000000000_001_1110", -- movR r1

    5  => b"000000000_001_0001", -- add r1
    6  => b"000000000_001_1110", -- movR r1
    
    7  => b"000000000_001_0001", -- add r1
    8  => b"000000000_001_1110", -- movR r1
    
    9  => b"000000000_001_0001", -- add r1
    10  => b"000000000_001_1110", -- movR r1

    11  => b"000000000_001_0001", -- add r1
    12  => b"000000000_001_1110", -- movR r1

    13  => b"000000000_001_0001", -- add r1
    14  => b"000000000_001_1110", -- movR r1

    15  => b"000000000_001_0001", -- add r1
    16  => b"000000000_001_1110", -- movR r1

    17  => b"000000000_001_0001", -- add r1
    18  => b"000000000_001_1110", -- movR r1

    19  => b"000000000_001_0001", -- add r1
    20  => b"000000000_001_1110", -- movR r1

    21  => b"000000111_010_1000", -- ld r2, 000000111
    22  => b"000000011_011_1000", -- ld r3, 000000011
    23  => b"000000000_010_1101", -- movA r2
    24  => b"000000000_011_0010", -- sub r3

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
