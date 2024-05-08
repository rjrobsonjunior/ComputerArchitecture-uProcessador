library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
    port (
        clk   : in std_logic;
        instruction : in unsigned(13 downto 0);
        PCclock, ROMclock : out std_logic;
        jump : out std_logic;
        
        PC_reset : in std_logic;
        PC : out unsigned(6 downto 0)
    );
end entity ControlUnit;

architecture rtl of ControlUnit is
    
    component stateMachine is
        port( clk      : in std_logic;
              rst      : in std_logic;
              state : out std_logic
        );
    end component;

    component ProgramCounter is
        port(
        clk, reset, wren : in std_logic;
        datain: in unsigned (6 downto 0);
        counter: out unsigned(6 downto 0)
    );
    end component;

    signal state : std_logic := '0';
    signal opcode : unsigned(3 downto 0);
    
    signal PC_wr_en_s : std_logic := '1';
    signal PC_reset_s : std_logic := '0';
    signal PC_datain_s : unsigned (6 downto 0);
    signal PC_counter_s : unsigned (6 downto 0);
begin
    stateMachine_component : stateMachine port map (
        clk => clk,
        rst => '0',
        state => state
    );

    PC_component : ProgramCounter port map (
        clk => clk,
        reset => PC_reset_s,
        wren => PC_wr_en_s,
        datain => PC_datain_s,
        counter => PC_counter_s
    );

    PC_datain_s <= PC_counter_s + "0000001";
    PC_reset_s <= PC_reset;

    opcode <= instruction(13 downto 10);
    jump <= '1' when opcode = "1111" else '0';
    
    PCclock <= not state;
    ROMclock <= state;

end architecture;
