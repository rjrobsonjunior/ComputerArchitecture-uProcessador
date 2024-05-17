library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
    port (
        clk          : in std_logic;
        instruction  : in unsigned(15 downto 0);
        jump_addr    : out unsigned(6 downto 0);

        jump         : out std_logic;
        rb_mux       : out std_logic;
        rb_wr_en     : out std_logic;
        ula_src_mux  : out std_logic;
        ula_selector : out unsigned(1 downto 0);
        acc_mux      : out std_logic;
        acc_wr_en    : out std_logic;

        fetchState, decodeState, executeState  : out std_logic
    );
end entity ControlUnit;

architecture rtl of ControlUnit is

    component stateMachine is
        port( clk      : in std_logic;
              rst      : in std_logic;
              state : out unsigned ( 1 downto 0)
        );
    end component;
    signal reset : std_logic := '0';
    signal state : unsigned (1 downto 0) := "00";
    signal opcode : unsigned(3 downto 0);
    signal tmp_acc_wr_en : std_logic;
    signal fetchState_s, decodeState_s, executeState_s : std_logic;
    signal tmp_rb_wr_en : std_logic;
begin
    stateMachine_component : stateMachine port map (
        clk => clk,
        rst => reset,
        state => state
    );

    opcode <= instruction(3 downto 0);
    jump <= '1' when opcode = "1111" else '0';
    jump_addr <= '0'&instruction(15 downto 10); --concatena
    reset <= '1' when opcode = "1111" else '0';

    fetchState_s <= '1' when state = "00" else '0';
    decodeState_s <= '1' when state = "01" else '0';
    executeState_s <= '1' when state = "10" else '0';
    
    fetchState <= fetchState_s;
    decodeState <= decodeState_s;
    executeState <= executeState_s;

    rb_mux <= '1' when opcode = "1000" else '0'; -- ld
    tmp_rb_wr_en <= '1' when opcode = "1000" or opcode = "1110" else '0'; -- ld or movr
    rb_wr_en <= tmp_rb_wr_en and decodeState_s;

    ula_src_mux  <= '1' when opcode = "1001" else '0'; --addi
    ula_selector <= "00" when opcode = "1001" else --addi
                    "00" when opcode = "0001" else  --add
                    "01" when opcode = "0010" else --sub
                    "10" when opcode = "0011" else --xor
                    "10" when opcode = "0100" else --and
                    "00";

    acc_mux <= '1' when opcode = "1101" else '0'; --mova
    tmp_acc_wr_en <= '1' when opcode = "0001" else --add
                 '1' when opcode = "0010" else --sub
                 '1' when opcode = "0011" else --xor
                 '1' when opcode = "0100" else --and
                 '1' when opcode = "1101" else --movA
                 '0'; -- 1 for all R except for MOVR
    acc_wr_en <= tmp_acc_wr_en and decodeState_s;
end architecture;
