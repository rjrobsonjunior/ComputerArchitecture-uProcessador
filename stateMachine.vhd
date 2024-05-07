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
    signal state0 : std_logic;
begin
    state0 <= state;
    process(clk,rst)
    begin                
        if rst='1' then
            state <=  '0';
        end if;
        if rising_edge(clk) then
            state<= not state0;
        end if;
    end process;

end architecture;
