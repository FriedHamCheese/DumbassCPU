----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 02:50:37 PM
-- Design Name: 
-- Module Name: InstructionBitOutputSelector_UnitTest - Behavioral
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

entity InstructionBitOutputSelector_UnitTest is
--  Port ( );
end InstructionBitOutputSelector_UnitTest;

architecture Behavioral of InstructionBitOutputSelector_UnitTest is

component InstructionBitOutputSelector is Port(
    input_bits: in std_logic_vector (15 downto 0);
    selecting_bits: in std_Logic_vector (3 downto 0);
    selected_bit: out std_logic
);
end component;

signal selecting_bits: std_logic_vector(3 downto 0);
signal selected_bit: std_logic;

begin
    selector: InstructionBitOutputSelector port map("1010101010101010", selecting_bits, selected_bit);
    proc: process is
    begin
        assert(false = true)
        report "---- InstructionBitOutputSelector_UnitTest Begin ----"
        severity note;
        
        selecting_bits <= "0000";
        wait for 20ns;
        assert(selected_bit = '0')
        report "InstructionBitOutputSelector_UnitTest: failed case 0 ----"
        severity error;    
        
        selecting_bits <= "0001";
        wait for 20ns;
        assert(selected_bit = '1')
        report "InstructionBitOutputSelector_UnitTest: failed case 1 ----"
        severity error;    
        
        assert(false = true)
        report "---- InstructionBitOutputSelector_UnitTest End ----"
        severity note;
        wait;
    end process proc;

end Behavioral;
