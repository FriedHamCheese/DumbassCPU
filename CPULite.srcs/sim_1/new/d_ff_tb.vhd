library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_tb is
end d_ff_tb;

architecture Behavioral of d_ff_tb is
    component d_ff
        Port (
            clk : in  STD_LOGIC;
            we  : in  STD_LOGIC;
            d   : in  STD_LOGIC;
            q   : out STD_LOGIC
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal we  : STD_LOGIC := '0';
    signal d   : STD_LOGIC := '0';
    signal q   : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin
    uut: d_ff
        Port map (
            clk => clk,
            we  => we,
            d   => d,
            q   => q
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        wait for 20 ns;

        -- Test case 1: Write enable is 0, no change in output
        d <= '1';
        we <= '0';
        wait for clk_period;

        -- Test case 2: Write enable is 1, output should change to input
        we <= '1';
        wait for clk_period;

        -- Test case 3: Change input while write enable is 1
        d <= '0';
        wait for clk_period;

        -- Test case 4: Write enable is 0 again, output should hold
        we <= '0';
        d <= '1';
        wait for clk_period;

        -- End simulation
        wait;
    end process;
end Behavioral;