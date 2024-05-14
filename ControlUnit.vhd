library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
    port (
        clk          : in std_logic;
        instruction  : in unsigned(15 downto 0);
        jump         : out std_logic;
        jump_addr    : out unsigned(6 downto 0);
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
    

    fetchState <= '1' when state = "00" else '0';
    decodeState <= '1' when state = "01" else '0';
    executeState <= '1' when state = "10" else '0';
end architecture;
