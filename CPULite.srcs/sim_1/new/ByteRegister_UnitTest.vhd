----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 05:47:32 PM
-- Design Name: 
-- Module Name: ByteRegister_UnitTest - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ByteRegister_UnitTest is
--  Port ( );
end ByteRegister_UnitTest;

architecture Behavioral of ByteRegister_UnitTest is

component ByteRegister is Port(
    data_in: in std_logic_vector(7 downto 0);
    overwrite: in std_logic;
    rising_edge_clk: in std_logic;
    data_out: out std_logic_vector(7 downto 0)
);
end component;

signal data_in, data_out: std_logic_vector(7 downto 0);
signal overwrite, clk: std_logic;

begin
    reg: ByteRegister port map(data_in, overwrite, clk, data_out);

    proc: process is
    begin
        assert(false)
        report "---- ByteRegister_UnitTest begin ----"
        severity note;
        
        overwrite <= '1';
        data_in <= "10101010";
        wait for 110ns;
        assert(data_out = "10101010")
        report "Failed at case 0: overwrite"
        severity error;
        
        overwrite <= '0';
        data_in <= "00000000";
        wait for 100ns;
        assert(data_out = "10101010")
        report "Failed at case 1: to not overwrite"
        severity error;
        
        overwrite <= '0';
        data_in <= "10011101";
        wait for 100ns;
        assert(data_out = "10101010")
        report "Failed at case 2: to not overwrite"
        severity error;
        
        overwrite <= '1';
        data_in <= "10011101";
        wait for 100ns;
        assert(data_out = "10011101")
        report "Failed at case 3: overwrite"
        severity error;
        
        assert(false)
        report "---- ByteRegister_UnitTest end ----"
        severity note;
        wait;
    end process proc;

end Behavioral;
