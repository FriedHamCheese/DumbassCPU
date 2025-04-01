library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory16x8_tb is
end memory16x8_tb;

architecture Behavioral of memory16x8_tb is

    -- Component Declaration for the 16x8 memory
    component memory16x8
        Port (
            clk  : in  STD_LOGIC;
            we   : in  STD_LOGIC;
            addr : in  STD_LOGIC_VECTOR(3 downto 0);
            din  : in  STD_LOGIC_VECTOR(7 downto 0);
            dout : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Testbench signals
    signal clk_tb   : STD_LOGIC := '0';
    signal we_tb    : STD_LOGIC := '0';
    signal addr_tb  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal din_tb   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal dout_tb  : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 10 ns;

begin
    -- Instantiate the memory
    UUT: memory16x8
        port map(
            clk  => clk_tb,
            we   => we_tb,
            addr => addr_tb,
            din  => din_tb,
            dout => dout_tb
        );

    -- Clock generation process: runs for about 1000 ns
    clock_gen: process
    begin
        while now < 1000 ns loop
            clk_tb <= '0';
            wait for clk_period/2;
            clk_tb <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process: Write values to some addresses and then read them back
    stim_proc: process
    begin
        -- Write operations (we_tb = '1')
        we_tb   <= '1';
        
        -- Write to address 0: store 0x01
        addr_tb <= "0000";
        din_tb  <= "00000001";
        wait for clk_period;
        
        -- Write to address 1: store 0x02
        addr_tb <= "0001";
        din_tb  <= "00000010";
        wait for clk_period;
        
        -- Write to address 2: store 0x55
        addr_tb <= "0010";
        din_tb  <= "01010101";
        wait for clk_period;
        
        -- Write to address 15: store 0xFF
        addr_tb <= "1111";
        din_tb  <= "11111111";
        wait for clk_period;
        
        -- Deassert write enable
        we_tb <= '0';
        wait for clk_period;
        
        -- Read operations (we_tb = '0')
        -- Read back address 0
        addr_tb <= "0000";
        wait for clk_period;
        assert (dout_tb = "00000001")
            report "Error: Expected 0x01 at address 0" severity error;
        
        -- Read back address 1
        addr_tb <= "0001";
        wait for clk_period;
        assert (dout_tb = "00000010")
            report "Error: Expected 0x02 at address 1" severity error;
        
        -- Read back address 2
        addr_tb <= "0010";
        wait for clk_period;
        assert (dout_tb = "01010101")
            report "Error: Expected 0x55 at address 2" severity error;
        
        -- Read back address 15
        addr_tb <= "1111";
        wait for clk_period;
        assert (dout_tb = "11111111")
            report "Error: Expected 0xFF at address 15" severity error;
        
        report "Memory test completed successfully." severity note;
        wait;
    end process;

end Behavioral;
