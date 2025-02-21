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
        overwrite <= '0';
        data_in <= "00000000";
        wait for 100ns;
        assert(data_out = "00000000");  
        
        overwrite <= '1';
        data_in <= "10101010";
        wait for 100ns;
        assert(data_out = "10101010");
        
        overwrite <= '0';
        data_in <= "00000000";
        wait for 100ns;
        assert(data_out = "10101010");      
        
        wait;
    end process proc;

end Behavioral;
