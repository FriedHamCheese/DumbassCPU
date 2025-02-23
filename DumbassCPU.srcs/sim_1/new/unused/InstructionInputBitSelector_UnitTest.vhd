----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 12:29:49 PM
-- Design Name: 
-- Module Name: InstructionInputBitSelector_UnitTest - Behavioral
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

entity InstructionInputBitSelector_UnitTest is
--  Port ( );
end InstructionInputBitSelector_UnitTest;

architecture Behavioral of InstructionInputBitSelector_UnitTest is

component InstructionInputBitSelector is Port(
    input_bit: in std_logic;
    selecting_bits: in std_logic_vector (3 downto 0);
    output_bits: out std_logic_vector (15 downto 0)
);
end component;

signal selecting_bits: std_logic_vector (3 downto 0);
signal output_bits: std_logic_vector (15 downto 0);

begin
    bitsel: InstructionInputBitSelector port map('1', selecting_bits, output_bits);
    
    proc: process is
    begin
        selecting_bits <= "0000";
        wait for 20ns;
        assert(
            output_bits(15) = '0'
            and output_bits(14) = '0'
            and output_bits(13) = '0' 
            and output_bits(12) = '0' 
            and output_bits(11) = '0' 
            and output_bits(10) = '0' 
            and output_bits(9) =  '0'
            and output_bits(8) =  '0'
            and output_bits(7) =  '0'
            and output_bits(6) =  '0'
            and output_bits(5) =  '0'
            and output_bits(4) =  '0'
            and output_bits(3) =  '0'
            and output_bits(2) =  '0'
            and output_bits(1) =  '0'
            and output_bits(0) =  '1'
        )
        report "InstructionInputBitSelector_UnitTest: Failed case 0"
        severity error;

        selecting_bits <= "0001";
        wait for 20ns;
        assert(
            output_bits(15) = '0'
            and output_bits(14) = '0'
            and output_bits(13) = '0' 
            and output_bits(12) = '0' 
            and output_bits(11) = '0' 
            and output_bits(10) = '0' 
            and output_bits(9) =  '0'
            and output_bits(8) =  '0'
            and output_bits(7) =  '0'
            and output_bits(6) =  '0'
            and output_bits(5) =  '0'
            and output_bits(4) =  '0'
            and output_bits(3) =  '0'
            and output_bits(2) =  '0'
            and output_bits(1) =  '1'
            and output_bits(0) =  '0'
        )
        report "InstructionInputBitSelector_UnitTest: Failed case 1"
        severity error;
        
        selecting_bits <= "0010";
        wait for 20ns;
        assert(
            output_bits(15) = '0'
            and output_bits(14) = '0'
            and output_bits(13) = '0' 
            and output_bits(12) = '0' 
            and output_bits(11) = '0' 
            and output_bits(10) = '0' 
            and output_bits(9) =  '0'
            and output_bits(8) =  '0'
            and output_bits(7) =  '0'
            and output_bits(6) =  '0'
            and output_bits(5) =  '0'
            and output_bits(4) =  '0'
            and output_bits(3) =  '0'
            and output_bits(2) =  '1'
            and output_bits(1) =  '0'
            and output_bits(0) =  '0'
        )
        report "InstructionInputBitSelector_UnitTest: Failed case 2"
        severity error;
        
        selecting_bits <= "0011";
        wait for 20ns;
        assert(
            output_bits(15) = '0'
            and output_bits(14) = '0'
            and output_bits(13) = '0' 
            and output_bits(12) = '0' 
            and output_bits(11) = '0' 
            and output_bits(10) = '0' 
            and output_bits(9) =  '0'
            and output_bits(8) =  '0'
            and output_bits(7) =  '0'
            and output_bits(6) =  '0'
            and output_bits(5) =  '0'
            and output_bits(4) =  '0'
            and output_bits(3) =  '1'
            and output_bits(2) =  '0'
            and output_bits(1) =  '0'
            and output_bits(0) =  '0'
        )
        report "InstructionInputBitSelector_UnitTest: Failed case 3"
        severity error;
        
        wait;
    end process proc;

end Behavioral;
