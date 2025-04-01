library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplier8Bit_tb is
end Multiplier8Bit_tb;

architecture test of Multiplier8Bit_tb is
    signal a, b : STD_LOGIC_VECTOR(7 downto 0);
    signal c : STD_LOGIC_VECTOR(7 downto 0);

    -- Instantiate the Unit Under Test (UUT)
    component Multiplier8Bit
        Port (
            a : in  STD_LOGIC_VECTOR (7 downto 0);
            b : in  STD_LOGIC_VECTOR (7 downto 0);
            c : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

begin
    UUT: Multiplier8Bit port map(a => a, b => b, c => c);

    process
    begin
        -- Test Case 1: 0 * 0 = 0
        a <= "00000000"; b <= "00000000";
        wait for 10 ns;
        assert c = "00000000" report "Test Case 1 Failed" severity error;

        -- Test Case 2: 1 * 1 = 1
        a <= "00000001"; b <= "00000001";
        wait for 10 ns;
        assert c = "00000001" report "Test Case 2 Failed" severity error;

        -- Test Case 3: 2 * 3 = 6
        a <= "00000010"; b <= "00000011";
        wait for 10 ns;
        assert c = "00000110" report "Test Case 3 Failed" severity error;

        -- Test Case 4: 15 * 15 = 225 (mod 256) = 225
        a <= "00001111"; b <= "00001111";
        wait for 10 ns;
        assert c = "11100001" report "Test Case 4 Failed" severity error;

        -- Test Case 5: 127 * 2 = 254
        a <= "01111111"; b <= "00000010";
        wait for 10 ns;
        assert c = "11111110" report "Test Case 5 Failed" severity error;

        -- Test Case 6: 255 * 255 = 65025 (mod 256) = 1
        a <= "11111111"; b <= "11111111";
        wait for 10 ns;
        assert c = "00000001" report "Test Case 6 Failed" severity error;

        -- Test Case 7: 2 * 2 = 4
        a <= "00000010"; b <= "00000010";
        wait for 10 ns;
        assert c = "00000100" report "Test Case 7 Failed" severity error;

        -- Test Case 8: 3 * 3 = 9
        a <= "00000011"; b <= "00000011";
        wait for 10 ns;
        assert c = "00001001" report "Test Case 8 Failed" severity error;

        -- Test Case 9: 4 * 4 = 16
        a <= "00000100"; b <= "00000100";
        wait for 10 ns;
        assert c = "00010000" report "Test Case 9 Failed" severity error;

        -- Test Case 10: 5 * 5 = 25
        a <= "00000101"; b <= "00000101";
        wait for 10 ns;
        assert c = "00011001" report "Test Case 10 Failed" severity error;

        -- Test Case 11: 6 * 6 = 36
        a <= "00000110"; b <= "00000110";
        wait for 10 ns;
        assert c = "00100100" report "Test Case 11 Failed" severity error;

        wait;
    end process;
end test;
