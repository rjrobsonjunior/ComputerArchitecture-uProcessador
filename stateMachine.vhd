library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stateMachine is
   port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         state : out std_logic
   );
end entity;


architecture a_stateMachine of stateMachine is
   signal registro: unsigned(15 downto 0);
   signal tmp : std_logic;
begin
   process(clk,rst,wr_en)
   begin                
      if rst='1' then
         tmp <=  '0';
      elsif wr_en='1' then
         if rising_edge(clk) then
            tmp<= not tmp;
         end if;
      end if;
   end process;
   state <= tmp;  
end architecture;