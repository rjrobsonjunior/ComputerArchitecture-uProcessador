library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Top_Level is
    port(
        clk : in std_logic;
        
        PC_reset : in std_logic;
        PC       : out unsigned(6 downto 0);
        state    : out unsigned(1 downto 0);

        data : out unsigned(15 downto 0);

        acc_out : out unsigned(15 downto 0);
        rd_out  : out unsigned(15 downto 0);
        ula_out : out unsigned(15 downto 0)
    );
end entity;


architecture rtl of Top_Level is

    component PC_Adder is
        port (
            clk : in std_logic;

            jump_flag_abs : in std_logic;
            jump_flag_rel : in std_logic;
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

    component RAM is
        port (
            clk : in std_logic;
            addr : in unsigned(15 downto 0);
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component ControlUnit is 
        port (
            clk           : in std_logic;
            instruction   : in unsigned(15 downto 0);
            carry_flag    : in std_logic;
            zero_flag     : in std_logic;
            overflow_flag : in std_logic;
            negative_flag : in std_logic;

            ram_wr_en     : out std_logic;
            jump_addr     : out unsigned(6 downto 0);
            jump_abs      : out std_logic;
            jump_rel      : out std_logic;
            rb_mux        : out std_logic;
            rb_wr_en      : out std_logic;
            ula_selector  : out unsigned(1 downto 0);
            ula_src_mux   : out std_logic;
            acc_mux       : out unsigned(1 downto 0);
            acc_wr_en     : out std_logic;
            fetchState, decodeState, executeState  : out std_logic;
            state         : out unsigned(1 downto 0)
    );
    end component;

    component InstructionRegister port (
        clk, clkFetch  : in std_logic;
        reset : in std_logic;
        instruction : in unsigned(15 downto 0);
        B_format_instruction, I_format_instruction, R_format_instruction : out std_logic;
        ImmValue : out unsigned( 15 downto 0);  
        addressReg1: out unsigned( 2 downto 0)
    );
    end component;

    component ULA_RegBank is
        port (
                clk, rst, wr_en  : in std_logic;
                rd_address       : in unsigned(2 downto 0);
                rb_mux_selector  : in std_logic;
                ula_src_selector : in std_logic;
                ula_selector     : in unsigned(1 downto 0);
                acc_wr_en        : in std_logic;
                acc_mux_selector : in unsigned(1 downto 0);
                imm_value        : in unsigned(15 downto 0);
                ram_out          : in unsigned(15 downto 0);

                ula_carry    : out std_logic;
                ula_overflow : out std_logic;
                ula_bigger   : out std_logic;
                ula_smaller  : out std_logic;
                ula_zero     : out std_logic;
                ula_negative : out std_logic;
            
                ula_output : out unsigned(15 downto 0);
    
                accumulator : out unsigned(15 downto 0);
                rd_out      : out unsigned(15 downto 0)
             );
    end component;

    signal jump_flag_s_abs, jump_flag_s_rel : std_logic;
    signal jump_addr_s : unsigned(6 downto 0);
    signal fetchState, decodeState, executeState : std_logic;
    signal state_s : unsigned(1 downto 0);

    signal current_addr_s : unsigned(6 downto 0);
    signal data_s : unsigned(15 downto 0);
    signal immediate_s : unsigned(15 downto 0);

    signal Binstruction, Iinstruction, Rinstruction : std_logic;
    signal ula_selector : unsigned(1 downto 0);
    signal rd: unsigned(2 downto 0);
    signal ula_bigger, ula_carry, ula_overflow,ula_negative, ula_smaller, ula_zero: std_logic;

    signal ula_src_mux_s : std_logic;
    signal rb_mux_s    : std_logic;
    signal rb_wr_en_s  : std_logic;
    signal acc_mux_s   : unsigned(1 downto 0);
    signal acc_wr_en_s : std_logic;
    signal ram_wr_en_s : std_logic;

    signal ram_out_s   : unsigned(15 downto 0);
    signal rd_out_s    : unsigned(15 downto 0);
    signal acc_out_s   : unsigned(15 downto 0);
begin
    PC_Adder_component : PC_Adder port map (
        clk => clk,
        jump_flag_abs => jump_flag_s_abs,
        jump_flag_rel => jump_flag_s_rel,
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

    RAM_component : RAM port map (
        clk => clk,
        addr => rd_out_s,
        wr_en => ram_wr_en_s,
        data_in => acc_out_s,
        data_out => ram_out_s
    );
    
    ControlUnit_component : ControlUnit port map (
        clk           => clk,
        instruction   => data_s,
        carry_flag    => ula_carry,
        zero_flag     => ula_zero,
        overflow_flag => ula_overflow,
        negative_flag => ula_negative,

        ram_wr_en     => ram_wr_en_s,
        jump_abs      => jump_flag_s_abs,
        jump_rel      => jump_flag_s_rel,
        jump_addr     => jump_addr_s,
        rb_mux        => rb_mux_s,
        rb_wr_en      => rb_wr_en_s,
        ula_src_mux   => ula_src_mux_s,
        ula_selector  => ula_selector,
        acc_mux       => acc_mux_s,
        acc_wr_en     => acc_wr_en_s,
        fetchState    => fetchState,
        decodeState   => decodeState,
        executeState  => executeState,
        state         => state_s
    );
    Intructioncomponent : InstructionRegister port map(
        clk                   => clk,
        clkFetch              => fetchState,
        reset                 => PC_reset,
        instruction           => data_s,
        B_format_instruction  => Binstruction,
        I_format_instruction  => Iinstruction,
        R_format_instruction  => Rinstruction,

        ImmValue              => immediate_s,
        addressReg1           => rd
    );

    ULA_RegBank_component : ULA_RegBank port map (
        clk              => clk,  
        rst              => PC_reset,
        wr_en            => rb_wr_en_s,
        rd_address       => rd,
        rb_mux_selector  => rb_mux_s,
        ula_src_selector => ula_src_mux_s,
        ula_selector     => ula_selector,
        acc_wr_en        => acc_wr_en_s,
        acc_mux_selector => acc_mux_s,
        imm_value        => immediate_s,
        ram_out          => ram_out_s,

        ula_output       => ula_out,
        ula_carry        => ula_carry,
        ula_overflow     => ula_overflow,
        ula_bigger       => ula_bigger,
        ula_smaller      => ula_smaller,
        ula_zero         => ula_zero,
        ula_negative     => ula_negative,
        accumulator      => acc_out_s,
        rd_out           => rd_out_s
    );
    data <= data_s;
    state <= state_s;
    PC <= current_addr_s;
    rd_out <= rd_out_s;
    acc_out <= acc_out_s;

end architecture;
