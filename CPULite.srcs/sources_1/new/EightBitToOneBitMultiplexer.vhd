----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2025 06:57:37 PM
-- Design Name: 
-- Module Name: EightBitToOneBitMultiplexer - Dataflow
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

entity EightBitToOneBitMultiplexer is Port(
    input_bits: in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(2 downto 0);
    selected_bit: out std_logic
);
end EightBitToOneBitMultiplexer;

architecture Dataflow of EightBitToOneBitMultiplexer is 

signal internal_selected_bit: std_logic := '0';
signal selecting_bits_and : std_logic_vector(7 downto 0) := "00000000";

begin
    selecting_bits_and(7) <= (selecting_bits(2)) and (selecting_bits(1)) and (selecting_bits(0));
    selecting_bits_and(6) <= (selecting_bits(2)) and (selecting_bits(1)) and (not selecting_bits(0));    
    selecting_bits_and(5) <= (selecting_bits(2)) and (not selecting_bits(1)) and (selecting_bits(0));
    selecting_bits_and(4) <= (selecting_bits(2)) and (not selecting_bits(1)) and (not selecting_bits(0));
    selecting_bits_and(3) <= (not selecting_bits(2)) and (selecting_bits(1)) and (selecting_bits(0));
    selecting_bits_and(2) <= (not selecting_bits(2)) and (selecting_bits(1)) and (not selecting_bits(0));    
    selecting_bits_and(1) <= (not selecting_bits(2)) and (not selecting_bits(1)) and (selecting_bits(0));
    selecting_bits_and(0) <= (not selecting_bits(2)) and (not selecting_bits(1)) and (not selecting_bits(0));

    internal_selected_bit <= (input_bits(7) and selecting_bits_and(7)) 
                            or (input_bits(6) and selecting_bits_and(6))
                            or (input_bits(5) and selecting_bits_and(5))
                            or (input_bits(4) and selecting_bits_and(4))
                            or (input_bits(3) and selecting_bits_and(3))
                            or (input_bits(2) and selecting_bits_and(2))
                            or (input_bits(1) and selecting_bits_and(1))
                            or (input_bits(0) and selecting_bits_and(0));    
    selected_bit <= internal_selected_bit;
end Dataflow;
