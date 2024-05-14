library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decode_RegBank_ULA is
    port (
        instruction     : out unsigned(15 downto 0);
        clk, rst        : in std_logic;
        ula_carry       : out std_logic;
        ula_overflow    : out std_logic;
        ula_bigger      : out std_logic;
        ula_smaller     : out std_logic;
        ula_output      : out unsigned(15 downto 0);

        accumulator : out unsigned(15 downto 0)   
    );
end entity Decode_RegBank_ULA;

architecture rtl of Decode_RegBank_ULA is
    component ControlUnit is 
        port (
            clk          : in std_logic;
            instruction  : in unsigned(15 downto 0);
            jump         : out std_logic;
            jump_addr    : out unsigned(6 downto 0);
            fetchState, decodeState, executeState  : out std_logic
    );
    end component;

    component InstructionDecoder port (
        clk   : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        ula_selector : out unsigned(1 downto 0 );
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ula_input_Instruction : out unsigned( 15 downto 0) -- value form instruction type I and B, like addi, subi, be 
    );
    end component;
    
    component ULA_RegBank is
        port (
                clk, rst, wr_en : in std_logic;
                r_data_1_mux_selector    : in std_logic;
                r_data_2_mux_selector    : in std_logic;
    
                rb_address1     : in unsigned(2 downto 0);
                rb_address2     : in unsigned(2 downto 0);
                rb_wr_reg       : in unsigned(2 downto 0);
                
                mux_1_input   : in unsigned(15 downto 0);
                ula_selector    : in unsigned(1 downto 0);
                ula_carry       : out std_logic;
                ula_overflow    : out std_logic;
                ula_bigger      : out std_logic;
                ula_smaller     : out std_logic;
                ula_output      : out unsigned(15 downto 0);
    
                accumulator : out unsigned(15 downto 0)
             );
    end component;

begin

    

end architecture;