library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine is
   port( clk      : in std_logic;
         rst      : in std_logic;
         state : out std_logic
   );
end entity;


architecture a_stateMachine of stateMachine is
    signal state0 : std_logic := '0';
begin
    state <= state0;
    process(clk,rst)
    begin
        if rst='1' then
            state0 <= '0';
        elsif rising_edge(clk) then
            state0 <= not state0;
        end if;
    end process;
    state <= state0;

end architecture;
