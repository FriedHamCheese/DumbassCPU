library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder8Bit_TB is

end Adder8Bit_TB;

architecture Behavioral of Adder8Bit_TB is

    component Adder8Bit
        Port (
            A : in  STD_LOGIC_VECTOR (7 downto 0);
            B : in  STD_LOGIC_VECTOR (7 downto 0);
            Cin : in  STD_LOGIC;
            Sum : out  STD_LOGIC_VECTOR (7 downto 0);
            Cout : out  STD_LOGIC
        );
    end component;

    signal A : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal Cin : STD_LOGIC := '0';

    signal Sum : STD_LOGIC_VECTOR (7 downto 0);
    signal Cout : STD_LOGIC;

begin

    uut: Adder8Bit port map (
        A => A,
        B => B,
        Cin => Cin,
        Sum => Sum,
        Cout => Cout
    );

    stim_proc: process
    begin
        -- Test vectors
        A <= "00000001"; B <= "00000001"; Cin <= '0'; wait for 10 ns;
        assert Sum = "00000010" and Cout = '0' report "Test Case 1 Failed" severity error;

        A <= "00000001"; B <= "00000001"; Cin <= '1'; wait for 10 ns;
        assert Sum = "00000011" and Cout = '0' report "Test Case 2 Failed" severity error;

        A <= "01111111"; B <= "00000001"; Cin <= '0'; wait for 10 ns;
        assert Sum = "10000000" and Cout = '0' report "Test Case 3 Failed" severity error;

        A <= "10000000"; B <= "10000000"; Cin <= '0'; wait for 10 ns;
        assert Sum = "00000000" and Cout = '1' report "Test Case 4 Failed" severity error;

        A <= "11111111"; B <= "00000001"; Cin <= '1'; wait for 10 ns;
        assert Sum = "00000001" and Cout = '1' report "Test Case 5 Failed" severity error;

        -- Indicate completion
        wait;
    end process;

end Behavioral;