library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Top_Level is
    port(
        clk : in std_logic;
        
        PC_reset : in std_logic;

        data : out unsigned(15 downto 0)
    );
end entity;


architecture rtl of Top_Level is

    component PC_Adder is
        port (
            clk : in std_logic;

            jump_flag : in std_logic;
            jump_addr : in unsigned(6 downto 0);

            PC_reset : in std_logic;
            PC_wr_en : in std_logic;
            PC : out unsigned(6 downto 0)
        );
    end component;

    component ROM is
        port (
            clk     : in std_logic;
            address : in unsigned(6 downto 0);
            data    : out unsigned(15 downto 0)
        );
    end component;

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
        ula_input_Instruction : out unsigned( 15 downto 0); -- value form instruction type I and B, like addi, subi, be
        addressReg1, addressReg2 : out unsigned( 2 downto 0) 
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

    signal jump_flag_s : std_logic;
    signal jump_addr_s : unsigned(6 downto 0);
    signal fetchState, decodeState, executeState : std_logic;
    signal Binstruction, Iinstruction, Rinstruction : std_logic;
    signal current_addr_s : unsigned(6 downto 0);
    signal data_s, ula_input_decode, resultULApartial : unsigned(15 downto 0);
    signal ula_selector : unsigned(1 downto 0);
    signal rb1, rb2 : unsigned(2 downto 0);
    signal ulabigger, ulacarry,ulaoverflow, ulasmaller, ula_bigger : std_logic;
begin
    PC_Adder_component : PC_Adder port map (
        clk => clk,
        jump_flag => jump_flag_s,
        jump_addr => jump_addr_s,
        PC_reset => PC_reset,
        PC_wr_en => decodeState,
        PC => current_addr_s
    );

    ROM_component : ROM port map (
        clk => clk,
        address => current_addr_s,
        data => data_s
    );
    
    ControlUnit_component : ControlUnit port map (
        clk => clk,
        instruction => data_s,
        jump => jump_flag_s,
        jump_addr => jump_addr_s,
        fetchState   => fetchState,
        decodeState  => decodeState,
        executeState => executeState 
    );
    Intructioncomponent : InstructionDecoder port map(
        clk                   => clk,
        reset                 => PC_reset,
        instruction           => data_s,
        ula_selector          => ula_selector,
        B_format_instruction  => Binstruction,
        I_format_instruction  => Iinstruction,
        R_format_instruction  => Rinstruction,
        ula_input_Instruction => ula_input_decode
    );

    ULA_RegBank_component : ULA_RegBank port map (
        clk                     => clk,  
        rst                     => PC_reset,
        wr_en                => executeState,
        r_data_1_mux_selector   => '0',
        r_data_2_mux_selector   => Binstruction,
        rb_address1     => rb1,
        rb_address2     => rb2,
        rb_wr_reg       => rb1,
        mux_1_input     => x"0000", --posteriormente trocar pelo salto relativo
        ula_selector    => ula_selector,
        ula_carry       => ulacarry,
        ula_overflow    => ulaoverflow,
        ula_bigger      => ulabigger,
        ula_smaller     => ulasmaller,
        ula_output      => resultULApartial,
        accumulator     => data
    );

    data <= data_s;

end architecture;
