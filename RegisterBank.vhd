library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterBank is
    port (
        adress1, adress2, writeRegister: in std_logic_vector(2 downto 0);
        datawr : unsigned(15 downto 0);
        wren, clk, rst: in std_logic;
        data1, data2 : out unsigned(15 downto 0)
    );
end entity RegisterBank;

architecture rtl of RegisterBank is

    component MUX4_16 is
        port (
        selector   : in unsigned (2 downto 0);
        inMUX      : in unsigned ( 127 downto 0); 
        outMUX     : out unsigned (15 downto 0) 
        );
    end component;

    component reg16bits is
    port( 
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
    ); 
    end component; 

    signal wren_register : std_logic_vector (7 downto 0);
    signal outEightRegisters: unsigned ( 127 downto 0);
begin
    wren_register(0) <= '0'; --0
    wren_register(1) <= (not writeRegister(0)) and (not writeRegister(1)) and ( writeRegister(2));    --1
    wren_register(2) <= (not writeRegister(0)) and ( writeRegister(1)) and (not writeRegister(2));    --2
    wren_register(3) <= (not writeRegister(0)) and (writeRegister(1)) and (writeRegister(2));         --3
    wren_register(4) <= ( writeRegister(0)) and ( not writeRegister(1)) and (not writeRegister(2));   --4
    wren_register(5) <= ( writeRegister(0)) and (not writeRegister(1)) and (writeRegister(2));        --5
    wren_register(6) <= (writeRegister(0)) and (writeRegister(1)) and (not writeRegister(2));         --6
    wren_register(7) <= (writeRegister(0)) and (writeRegister(1)) and (writeRegister(2));             --7

    gen00:for i in 0 to 7 generate
		register0 : reg16bits port map (
            clk      <= clk,
            rst      <= rst,
            wr_en    <= wren_register(i),
            data_in  <=  datawr,
            data_out <=  outEightRegisters( (16*(i+1))-1 downto 16*i )   
        );   
    end generate;

    mux1 : MUX4_16 port map (
        selector <= adress1,
        inMUX    <= outEightRegisters,
        outMUX   <= data1
    );
    
    mux2 : MUX4_16 port map (
        selector <= adress2,
        inMUX    <= eoutEightRegisters,
        outMUX   <= data1
    );

end architecture;