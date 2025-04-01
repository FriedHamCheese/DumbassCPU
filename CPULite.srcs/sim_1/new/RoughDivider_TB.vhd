library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RoughDivide_tb is
end RoughDivide_tb;

architecture Behavioral of RoughDivide_tb is
    component RoughDivide
        Port (
            Dividend : in std_logic_vector(7 downto 0);
            Divisor : in std_logic_vector(7 downto 0);
            Quotient : out std_logic_vector(7 downto 0)
        );
    end component;

    signal Dividend : std_logic_vector(7 downto 0) := (others => '0');
    signal Divisor : std_logic_vector(7 downto 0) := (others => '0');
    signal Quotient : std_logic_vector(7 downto 0);

begin
    uut: RoughDivide
        Port map (
            Dividend => Dividend,
            Divisor => Divisor,
            Quotient => Quotient
        );

    stim_proc: process
    begin
        -- Test Case 1: Divide 128 by 2
        Dividend <= "10000000"; -- 128
        Divisor <= "00000010"; -- 2
        wait for 10 ns;
        assert Quotient = "01000000" -- 64
            report "Test Case 1 Failed: 128 / 2 != 64" severity error;

        -- Test Case 2: Divide 64 by 4
        Dividend <= "01000000"; -- 64
        Divisor <= "00000100"; -- 4
        wait for 10 ns;
        assert Quotient = "00010000" -- 16
            report "Test Case 2 Failed: 64 / 4 != 16" severity error;

        -- Test Case 3: Divide 255 by 16
        Dividend <= "11111111"; -- 255
        Divisor <= "00010000"; -- 16
        wait for 10 ns;
        assert Quotient = "00001111" -- 15
            report "Test Case 3 Failed: 255 / 16 != 15" severity error;

        -- Edge Case 1: Divide by 1
        Dividend <= "11111111"; -- 255
        Divisor <= "00000001"; -- 1
        wait for 10 ns;
        assert Quotient = "11111111" -- 255
            report "Edge Case 1 Failed: 255 / 1 != 255" severity error;

        -- Edge Case 2: Divide by 0 (undefined behavior, expect 0)
        Dividend <= "11111111"; -- 255
        Divisor <= "00000000"; -- 0
        wait for 10 ns;
        assert Quotient = "00000000" -- 0
            report "Edge Case 2 Failed: Division by 0 did not result in 0" severity error;

        -- Edge Case 3: Divide 0 by any number
        Dividend <= "00000000"; -- 0
        Divisor <= "00000010"; -- 2
        wait for 10 ns;
        assert Quotient = "00000000" -- 0
            report "Edge Case 3 Failed: 0 / 2 != 0" severity error;

        wait;
    end process;
end Behavioral;