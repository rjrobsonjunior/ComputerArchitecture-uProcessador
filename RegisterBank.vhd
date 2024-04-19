library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterBank is
    port (
        adress1, adress2 : in std_logic_vector(3 downto 0);
        datawr, data1, data2 : in unsigned(15 downto 0);
        wren : in std_logic
    );
end entity RegisterBank;

architecture rtl of RegisterBank is

    component reg16bits is
    port( 
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
    );
    end component;

begin

    

end architecture;