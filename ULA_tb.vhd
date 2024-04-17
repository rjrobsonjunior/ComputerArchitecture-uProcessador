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
        inputA_tb <= x"0900";
        inputB_tb <= x"1000";
        selector_tb <= "00";
        wait for 50 ns;
        inputA_tb <= x"FFFF";
        inputB_tb <= x"FFFF";
        selector_tb <= "00";
        wait for 50 ns;
        inputA_tb <= x"0020";
        inputB_tb <= x"2020";
        selector_tb <= "00";
        wait for 50 ns;
        inputA_tb <= x"7777";
        inputB_tb <= x"9999";
        selector_tb <= "00";
        wait for 50 ns;
        inputA_tb <= x"9999";
        inputB_tb <= x"AAAA";
        selector_tb <= "01";
        wait for 50 ns;
        inputA_tb <= x"A99A";
        inputB_tb <= x"AAAA";
        selector_tb <= "01";
        wait for 50 ns;
        inputA_tb <= x"ABCD";
        inputB_tb <= x"AAAA";
        selector_tb <= "01";
        wait for 50 ns;
        inputA_tb <= x"1111";
        inputB_tb <= x"0000";
        selector_tb <= "01";
        wait for 50 ns;
        inputA_tb <= x"1111";
        inputB_tb <= x"0000";
        selector_tb <= "10";
        wait for 50 ns;
        inputA_tb <= x"ADDD";
        inputB_tb <= x"0101";
        selector_tb <= "10";
        wait for 50 ns;
        inputA_tb <= x"FFFF";
        inputB_tb <= x"DDDD";
        selector_tb <= "10";
        wait for 50 ns;
        inputA_tb <= x"1111";
        inputB_tb <= x"FFFF";
        selector_tb <= "11";
        wait for 50 ns;
        inputA_tb <= x"9999";
        inputB_tb <= x"0000";
        selector_tb <= "11";
        wait for 50 ns;
        inputA_tb <= x"1001";
        inputB_tb <= x"FFFF";
        selector_tb <= "11";
        wait for 50 ns;
        wait;
    end process;

end architecture;
