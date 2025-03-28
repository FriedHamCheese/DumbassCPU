library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_decoder_4to16 is
end tb_decoder_4to16;

architecture testbench of tb_decoder_4to16 is
    signal addr : STD_LOGIC_VECTOR (3 downto 0);  
    signal en : STD_LOGIC := '0';
    signal out_dec : STD_LOGIC_VECTOR (15 downto 0);

    component decoder4x16
        Port (
            addr    : in STD_LOGIC_VECTOR (3 downto 0); 
            en      : in STD_LOGIC;
            out_dec : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

begin
    UUT: entity work.decoder4x16
        Port map (
            addr => addr,
            en => en,
            out_dec => out_dec
        );

    process
    begin
        -- Test 1: Enable = 0
        addr <= "0000";  
        en <= '0';
        wait for 10 ns;
        assert out_dec = "0000000000000000" report "Test 1 failed" severity error;

        -- Test 2: Enable = 1, input = 0000
        addr <= "0000";  
        en <= '1';
        wait for 10 ns;
        assert out_dec = "0000000000000001" report "Test 2 failed" severity error;

        -- Test 3: Enable = 1, input = 0001
        addr <= "0001";  
        en <= '1';
        wait for 10 ns;
        assert out_dec = "0000000000000010" report "Test 3 failed" severity error;

        -- Test 4: Enable = 1, input = 0010
        addr <= "0010"; 
        en <= '1';
        wait for 10 ns;
        assert out_dec = "0000000000000100" report "Test 4 failed" severity error;

        -- Test 5: Enable = 1, input = 1111
        addr <= "1111";  
        en <= '1';
        wait for 10 ns;
        assert out_dec = "1000000000000000" report "Test 5 failed" severity error;

     
        wait;
    end process;
end testbench;