library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
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
        ula_src_mux   : out std_logic;
        ula_selector  : out unsigned(1 downto 0);
        acc_mux       : out unsigned(1 downto 0);
        acc_wr_en     : out std_logic;

        fetchState, decodeState, executeState  : out std_logic;
        state        : out  unsigned(1 downto 0)

    );
end entity ControlUnit;

architecture rtl of ControlUnit is

    component stateMachine is
        port( clk      : in std_logic;
              rst      : in std_logic;
              state : out unsigned ( 1 downto 0)
        );
    end component;

    component reg1bit is
       port(
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in std_logic;
            data_out : out std_logic
       );
    end component;

    signal reset : std_logic := '0';
    signal state_s : unsigned (1 downto 0) := "00";
    signal opcode : unsigned(3 downto 0);
    signal tmp_acc_wr_en : std_logic;
    signal fetchState_s, decodeState_s, executeState_s : std_logic;
    signal tmp_rb_wr_en : std_logic;
    signal tmp_ram_wr_en : std_logic;

    signal Cf_out_s, Nf_out_s, Zf_out_s, Of_out_s : std_logic := '0';
    signal flags_wren : std_logic := '0';
    signal tmp: unsigned(15 downto 0);
begin
    stateMachine_component : stateMachine port map (
        clk => clk,
        rst => reset,
        state => state_s
    );

    carryflag : reg1bit port map (
        clk => clk,
        rst => reset,
        wr_en => flags_wren,
        data_in => carry_flag,
        data_out => Cf_out_s
    );

    negativeflag : reg1bit port map (
        clk => clk,
        rst => reset,
        wr_en => flags_wren,
        data_in => negative_flag,
        data_out => Nf_out_s
    );

    zeroflag : reg1bit port map (
        clk => clk,
        rst => reset,
        wr_en => flags_wren,
        data_in => zero_flag,
        data_out => Zf_out_s
    );

    overflowflag : reg1bit port map (
        clk => clk,
        rst => reset,
        wr_en => flags_wren,
        data_in => overflow_flag,
        data_out => Of_out_s
    );
    flags_wren <= '1' when opcode = "0111" or opcode = "1001" or opcode = "0001" or opcode = "0010" or  opcode = "0011" or opcode = "0100" else '0';
    
    opcode <= instruction(3 downto 0);
    jump_abs <= '1' when opcode = "1111" else '0'; --jump

    jump_rel <= '1' when opcode = "0101" and Zf_out_s = '0' else        -- jz
                '1' when opcode = "1010" and Nf_out_s = '0' else        -- jn
                '1' when opcode = "0110" and Cf_out_s = '0' else '0';   -- jc
    
    jump_addr <= instruction(10 downto 4); 
    -- reset <= '1' when opcode = "1111" else '0';

    fetchState_s <= '1' when state_s = "00" else '0';
    decodeState_s <= '1' when state_s = "01" else '0';
    executeState_s <= '1' when state_s = "10" else '0';
    
    fetchState <= fetchState_s;
    decodeState <= decodeState_s;
    executeState <= executeState_s;

    rb_mux <= '1' when opcode = "1000" else '0'; -- ld 
    tmp_rb_wr_en <= '1' when opcode = "1000" or opcode = "1110" else '0'; -- ld or movr
        
    rb_wr_en <= tmp_rb_wr_en and decodeState_s;

    ula_src_mux  <= '1' when opcode = "1001" or opcode = "0111" else '0'; --addi and cmp

    ula_selector <= "00" when opcode = "1001" else -- addi
                    "00" when opcode = "0001" else -- add
                    "01" when opcode = "0010" else -- sub
                    "01" when opcode = "0111" else -- cmp
                    "10" when opcode = "0011" else -- xor
                    "10" when opcode = "0100" else -- and
                    "00";

    acc_mux <= "01" when opcode = "1101" else -- mova
               "10" when opcode = "1011" else -- lw
               "00";

    tmp_acc_wr_en <= '1' when opcode = "0001" else --add
                 '1' when opcode = "0010" else --sub
                 '1' when opcode = "0011" else --xor
                 '1' when opcode = "0100" else --and
                 '1' when opcode = "1101" else --movA
                 '1' when opcode = "1001" else --addi
                 '1' when opcode = "1011" else --lw
                 '0'; -- 1 for all R except for MOVR
    acc_wr_en <= tmp_acc_wr_en and decodeState_s;

    tmp_ram_wr_en <= '1' when opcode = "1100" else '0'; -- sw 
    ram_wr_en <= tmp_ram_wr_en and decodeState_s; -- sw

    --tmp <= '1' when opcode = ""

    state <= state_s;

    -- Set flags
    --tmp <= "1" when opcode = "0111";

end architecture;
