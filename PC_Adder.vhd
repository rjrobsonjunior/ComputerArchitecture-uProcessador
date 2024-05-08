library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_Adder is
    port (
        clk : in std_logic;

        jump_flag : in std_logic;
        jump_addr : in unsigned(6 downto 0);

        PC_reset : in std_logic;
        PC_wr_en : in std_logic;
        PC : out unsigned(6 downto 0)

    );
end entity;


architecture impl of PC_Adder is

    component ProgramCounter is
        port(
        clk, reset, wren : in std_logic;
        datain: in unsigned (6 downto 0);
        counter: out unsigned(6 downto 0)
    );
    end component;

    signal PC_wr_en_s : std_logic := '1';
    signal PC_reset_s : std_logic := '0';
    signal PC_datain_s : unsigned (6 downto 0);
    signal PC_counter_s : unsigned (6 downto 0);

begin

    PC_component : ProgramCounter port map (
        clk => clk,
        reset => PC_reset_s,
        wren => PC_wr_en_s,
        datain => PC_datain_s,
        counter => PC_counter_s
    );

    PC_datain_s <= PC_counter_s + "1" when jump_flag = '0' else
                   jump_addr when jump_flag = '1';

    PC_reset_s <= PC_reset;

end architecture;
