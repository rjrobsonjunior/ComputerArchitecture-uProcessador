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
            clk   : in std_logic;
            instruction : in unsigned(15 downto 0);
            jump : out std_logic;
            jump_addr : out unsigned(6 downto 0);
            fetchState, decodeState, executeState  : out std_logic
        );
    end component;

    signal jump_flag_s : std_logic;
    signal jump_addr_s : unsigned(6 downto 0);
    signal fetchState, decodeState, executeState : std_logic;

    signal current_addr_s : unsigned(6 downto 0);
    signal data_s : unsigned(15 downto 0);

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

    data <= data_s;

end architecture;
