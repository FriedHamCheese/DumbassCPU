library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg8_tb is
end reg8_tb;

architecture Behavioral of reg8_tb is

    component reg8
        Port (
            clk : in  STD_LOGIC;
            we  : in  STD_LOGIC;
            d   : in  STD_LOGIC_VECTOR(7 downto 0);
            q   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal we  : STD_LOGIC := '0';
    signal d   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal q   : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: reg8
        Port map (
            clk => clk,
            we  => we,
            d   => d,
            q   => q
        );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        -- Hold reset state for 100 ns.
        wait for 100 ns;

        -- Write data to the register
        we <= '1';
        d <= "00000001";
        wait for clk_period*2;
        
        d <= "00001111";
        wait for clk_period*2;

        d <= "10101010";
        wait for clk_period*2;

        -- Disable write enable and observe the output
        we <= '0';
        wait for clk_period*4;

        -- Write new data to the register (should not change due to we = '0')
        d <= "11110000";
        wait for clk_period*4;

        -- Enable write again and write new data
        we <= '1';
        d <= "11110000";
        wait for clk_period*2;

        -- End simulation
        wait;
    end process;

end Behavioral;