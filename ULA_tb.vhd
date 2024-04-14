library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end entity;

architecture rtl of ULA_tb is

    component ULA is
        port (
            selector : in unsigned(1 downto 0);
            inputA, inputB : in unsigned(15 downto 0);
            outResult : out unsigned(15 downto 0);
            carry, overflow, bigger, smaller : out std_logic
        );
    end component;

    signal selector_tb : unsigned(1 downto 0);
    signal inputA_tb, inputB_tb, outResult_tb : unsigned(15 downto 0);
    signal carry_tb, overflow_tb, bigger_tb, smaller_tb : std_logic;

begin
    ULAcomponent: ULA port map (
        selector => selector_tb,
        inputA => inputA_tb,
        inputB => inputB_tb,
        outResult => outResult_tb,
        carry => carry_tb,
        overflow => overflow_tb,
        bigger => bigger_tb,
        smaller => smaller_tb
    );
    process 
    begin
        inputA_tb <= "0000000000000111";
        inputB_tb <= "0000000000000000";
        selector_tb <= "00";
        wait for 50 ns;
        inputA_tb <= "0000000000000111";
        inputB_tb <= "0000000000111000";
        selector_tb <= "00";
        wait for 50 ns;
        inputA_tb <= "0000000000000000";
        inputB_tb <= "1111111111111111";
        selector_tb <= "01";
        wait for 50 ns;
        inputA_tb <= "0000000000000000";
        inputB_tb <= "1111111111111111";
        selector_tb <= "01";
        wait for 50 ns;
        wait for 50 ns;
        inputA_tb <= "1111111111111111";
        inputB_tb <= "0000000010000000";
        selector_tb <= "10";
        wait for 50 ns;
        wait for 50 ns;
        inputA_tb <= "0000000000000000";
        inputB_tb <= "1111111111111111";
        selector_tb <= "11";
        wait for 50 ns;
        wait for 50 ns;
        inputA_tb <= "1111111111111111";
        inputB_tb <= "0000000011111111";
        selector_tb <= "11";
        wait for 50 ns;
        wait;
    end process;

end architecture;
