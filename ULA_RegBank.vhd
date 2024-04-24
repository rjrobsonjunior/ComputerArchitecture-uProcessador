library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_RegBank is
    port (
            clk, rst, wr_en : in std_logic;
            mux_selector    : in std_logic;

            rb_address1     : in unsigned(2 downto 0);
            rb_address2     : in unsigned(2 downto 0);
            rb_wr_reg       : in unsigned(2 downto 0);
            
            ula_mux_input   : in unsigned(15 downto 0);
            ula_selector    : in unsigned(1 downto 0);
            ula_carry       : out std_logic;
            ula_overflow    : out std_logic;
            ula_bigger      : out std_logic;
            ula_smaller     : out std_logic;
            ula_output      : out unsigned(15 downto 0)
         );
end entity ULA_RegBank;


architecture impl of ULA_RegBank is

    component MUX2_16 is
        port (
                 input_signal : in std_logic;
                 input0       : in unsigned(15 downto 0);
                 input1       : in unsigned(15 downto 0);
                 output       : out unsigned(15 downto 0)
             );
    end component;

    component ULA is
        port (
                selector : in unsigned(1 downto 0);
                inputA, inputB : in unsigned(15 downto 0);
                outResult : out unsigned(15 downto 0);
                carry, overflow, bigger, smaller : out std_logic
             );
    end component;

    component RegisterBank is
        port (
                address1, address2, writeRegister: in unsigned(2 downto 0);
                datawr : in unsigned(15 downto 0);
                wren, clk, rst: in std_logic;
                data1, data2 : out unsigned(15 downto 0);
                outEightRegistersSignal : out unsigned ( 127 downto 0)
             );
    end component;


    signal regbank_read_data1 : unsigned(15 downto 0);
    signal regbank_read_data2 : unsigned(15 downto 0);
    signal mux_to_ula : unsigned(15 downto 0);
    signal ula_out_to_regbank_datawr : unsigned(15 downto 0);
    signal ula_out_signal : unsigned(15 downto 0);
begin
    
    mux_component: MUX2_16
    port map (
                 input_signal => mux_selector,
                 input0 => regbank_read_data2,
                 input1 => ula_mux_input,
                 output => mux_to_ula
             );

    ula_component: ULA
    port map (
                 selector => ula_selector,
                 inputA => regbank_read_data1,
                 inputB => mux_to_ula,
                 outResult => ula_out_signal,
                 carry => ula_carry,
                 overflow => ula_overflow,
                 bigger => ula_bigger,
                 smaller => ula_smaller
             );

    regbank_component: RegisterBank
    port map (
                 address1      => rb_address1,          
                 address2      => rb_address2,
                 writeRegister => rb_wr_reg,
                 datawr        => ula_out_signal,
                 wren          => wr_en,
                 clk           => clk,
                 rst           => rst,
                 data1         => regbank_read_data1,
                 data2         => regbank_read_data2
             );


    ula_output <= ula_out_signal;


end impl;
