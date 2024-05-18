library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterBank is
    port (
        address1, address2, writeRegister: in unsigned(2 downto 0);
        datawr : in unsigned(15 downto 0);
        wren, clk, rst: in std_logic;
        data1, data2 : out unsigned(15 downto 0);
        outEightRegistersSignal : out unsigned ( 127 downto 0)
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
        port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         data_in  : in unsigned(15 downto 0);
         data_out : out unsigned(15 downto 0)
   );
    end component; 

    signal wren_register : std_logic_vector (7 downto 0);
    signal outEightRegisters: unsigned ( 127 downto 0);
begin
    wren_register(0) <= '0'; -- Register zero cannot be written to
    wren_register(1) <= wren and (not writeRegister(2)) and (not writeRegister(1)) and ( writeRegister(0));    --1
    wren_register(2) <= wren and (not writeRegister(2)) and ( writeRegister(1)) and (not writeRegister(0));    --2
    wren_register(3) <= wren and (not writeRegister(2)) and (writeRegister(1)) and (writeRegister(0));         --3
    wren_register(4) <= wren and ( writeRegister(2)) and ( not writeRegister(1)) and (not writeRegister(0));   --4
    wren_register(5) <= wren and ( writeRegister(2)) and (not writeRegister(1)) and (writeRegister(0));        --5
    wren_register(6) <= wren and (writeRegister(2)) and (writeRegister(1)) and (not writeRegister(0));         --6
    wren_register(7) <= wren and (writeRegister(2)) and (writeRegister(1)) and (writeRegister(0));             --7

    gen00:for i in 0 to 7 generate
    begin
		registers00 : reg16bits port map (
            clk      => clk,
            rst      => rst,
            wr_en    => wren_register(i),
            data_in  =>  datawr,
            data_out => outEightRegisters( (16*(i+1))-1 downto 16*i )   
        );   
    end generate gen00;

    outEightRegistersSignal <= outEightRegisters;

    mux1 : MUX4_16 port map (
        selector => address1,
        inMUX    => outEightRegisters,
        outMUX   => data1
    );
    
    mux2 : MUX4_16 port map (
        selector => address2,
        inMUX    => outEightRegisters,
        outMUX   => data2
    );

end architecture;
