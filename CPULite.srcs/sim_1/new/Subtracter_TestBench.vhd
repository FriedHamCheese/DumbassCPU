library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Subtracter_TB is
-- Test bench has no ports
end Subtracter_TB;

architecture Behavioral of Subtracter_TB is

    -- Component Declaration for the Subtracter
    component Subtracter
        Port (
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            Difference : out  STD_LOGIC_VECTOR (7 downto 0);
            Borrow : out  STD_LOGIC
        );
    end component;

    -- Inputs
    signal A : STD_LOGIC_VECTOR (7 downto 0);
    signal B : STD_LOGIC_VECTOR (7 downto 0);

    -- Outputs
    signal Difference : STD_LOGIC_VECTOR (7 downto 0);
    signal Borrow : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Subtracter port map (
        A => A,
        B => B,
        Difference => Difference,
        Borrow => Borrow
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test vectors
        -- Positive numbers
        A <= "00001010"; B <= "00000011"; wait for 100 ns; -- 10 - 3 = 7
        A <= "00001010"; B <= "00001010"; wait for 100 ns; -- 10 - 10 = 0
        A <= "00000000"; B <= "00000001"; wait for 100 ns; -- 0 - 1 = -1 (two's complement: 11111111)
        A <= "11111111"; B <= "00000001"; wait for 100 ns; -- -1 - 1 = -2 (two's complement: 11111110)
        A <= "01100110"; B <= "01100110"; wait for 100 ns; -- 102 - 102 = 0

        -- Negative numbers (two's complement)
        A <= "11111111"; B <= "00000010"; wait for 100 ns; -- -1 - 2 = -3 (two's complement: 11111101)
        A <= "10011101"; B <= "00001010"; wait for 100 ns; -- -109 - 10 = -119 (two's complement: 10010011)
        A <= "10011101"; B <= "11111100"; wait for 100 ns; -- -109 - (-4) = -105 (two's complement: 10011011)

        -- End simulation
        wait;
    end process;

end Behavioral;
