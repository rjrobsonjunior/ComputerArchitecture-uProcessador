library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine is
   port( 
    clk      : in std_logic;
    rst      : in std_logic;
    state : out unsigned( 1 downto 0)
   );
end entity;


architecture a_stateMachine of stateMachine is
    signal state0 : unsigned( 1 downto 0) := "00";
begin
    process(clk,rst)
    begin
        if rst='1' then
            state0 <= "00";
        elsif rising_edge(clk) then
            if state0 = "10" then 
                state0 <= "00";
            else
                state0 <= state0 + 1;
            end if;
        end if;
    end process;
    state <= state0;
end architecture;
