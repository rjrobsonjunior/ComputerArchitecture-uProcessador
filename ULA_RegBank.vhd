library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_RegBank is
    port (
            clk, rst, wr_en, acc_wr_en : in std_logic;
            rb_mux_selector          : in std_logic;
            ula_src_selector         : in std_logic;
            acc_mux_selector         : in std_logic;
            rd_address      : in unsigned(2 downto 0);
            imm_value       : in unsigned(15 downto 0);
            ula_selector    : in unsigned(1 downto 0);
            ula_carry       : out std_logic;
            ula_overflow    : out std_logic;
            ula_bigger      : out std_logic;
            ula_smaller     : out std_logic;
            ula_zero        : out std_logic;
            ula_negative    : out std_logic;
            ula_output      : out unsigned(15 downto 0);
            accumulator     : out unsigned(15 downto 0);
            rd_out          : out unsigned(15 downto 0)
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
                carry, overflow, bigger, smaller, zero, negative : out std_logic
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


    signal regbank_read_data1, out_mux_ula_src, out_mux_rb, out_acc_mux: unsigned(15 downto 0);
    signal regbank_read_data2 : unsigned(15 downto 0);
    signal mux_1_to_ula : unsigned(15 downto 0);
    signal ula_out_signal : unsigned(15 downto 0) := x"0000";
    signal accumulator_s : unsigned(15 downto 0) := x"0000" ;
begin
    
    mux_RB: MUX2_16
    port map (
                input_signal => rb_mux_selector,
                input0 => accumulator_s,
                input1 => imm_value,
                output => out_mux_rb
            );

    mux_ula_src: MUX2_16
    port map (
                 input_signal => ula_src_selector,
                 input0 => regbank_read_data1,
                 input1 => imm_value,
                 output => out_mux_ula_src
             );
    
    mux_Acc: MUX2_16
    port map (
                input_signal => acc_mux_selector,
                input0 => ula_out_signal,
                input1 => regbank_read_data1,
                output => out_acc_mux
            );

    
    ula_component: ULA
    port map (
                 selector => ula_selector,
                 inputA => out_mux_ula_src,
                 inputB => accumulator_s,
                 outResult => ula_out_signal,
                 carry => ula_carry,
                 overflow => ula_overflow,
                 bigger => ula_bigger,
                 smaller => ula_smaller,
                 zero => ula_zero,
                 negative => ula_negative
             );

    regbank_component: RegisterBank
    port map (
                 address1      => rd_address,          
                 address2      => "000",
                 writeRegister => rd_address,
                 datawr        => out_mux_rb,
                 wren          => wr_en,
                 clk           => clk,
                 rst           => rst,
                 data1         => regbank_read_data1,
                 data2         => regbank_read_data2
             );


    ula_output <= ula_out_signal;

    process(clk)
    begin
        if rising_edge(clk) then
            if (acc_wr_en = '1') then
                accumulator_s <= out_acc_mux;
            end if;
        end if;
    end process;
    accumulator <= accumulator_s;
    rd_out <= regbank_read_data1;

end impl;
