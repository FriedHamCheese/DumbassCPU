----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 12:50:21 AM
-- Design Name: 
-- Module Name: InstructionInputBitSelector - Dataflow
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

entity InstructionInputBitSelector is Port(
    input_bit: in std_logic;
    selecting_bits: in std_logic_vector (3 downto 0);
    output_bits: out std_logic_vector (15 downto 0)
);
end InstructionInputBitSelector;

architecture Dataflow of InstructionInputBitSelector is

begin
    output_bits(15) <= input_bit and ((selecting_bits(3)) and (selecting_bits(2)) and (selecting_bits(1)) and (selecting_bits(0)));
    output_bits(14) <= input_bit and ((selecting_bits(3)) and (selecting_bits(2)) and (selecting_bits(1)) and (not selecting_bits(0)));
    output_bits(13) <= input_bit and ((selecting_bits(3)) and (selecting_bits(2)) and (not selecting_bits(1)) and (selecting_bits(0)));
    output_bits(12) <= input_bit and ((selecting_bits(3)) and (selecting_bits(2)) and (not selecting_bits(1)) and (not selecting_bits(0)));
    output_bits(11) <= input_bit and ((selecting_bits(3)) and (not selecting_bits(2)) and (selecting_bits(1)) and (selecting_bits(0)));
    output_bits(10) <= input_bit and ((selecting_bits(3)) and (not selecting_bits(2)) and (selecting_bits(1)) and (not selecting_bits(0)));
    output_bits(9) <= input_bit and ((selecting_bits(3)) and (not selecting_bits(2)) and (not selecting_bits(1)) and (selecting_bits(0)));
    output_bits(8) <= input_bit and ((selecting_bits(3)) and (not selecting_bits(2)) and (not selecting_bits(1)) and (not selecting_bits(0)));
    
    output_bits(7) <= input_bit and ((not selecting_bits(3)) and (selecting_bits(2)) and (selecting_bits(1)) and (selecting_bits(0)));
    output_bits(6) <= input_bit and ((not selecting_bits(3)) and (selecting_bits(2)) and (selecting_bits(1)) and (not selecting_bits(0)));
    output_bits(5) <= input_bit and ((not selecting_bits(3)) and (selecting_bits(2)) and (not selecting_bits(1)) and (selecting_bits(0)));
    output_bits(4) <= input_bit and ((not selecting_bits(3)) and (selecting_bits(2)) and (not selecting_bits(1)) and (not selecting_bits(0)));
    output_bits(3) <= input_bit and ((not selecting_bits(3)) and (not selecting_bits(2)) and (selecting_bits(1)) and (selecting_bits(0)));
    output_bits(2) <= input_bit and ((not selecting_bits(3)) and (not selecting_bits(2)) and (selecting_bits(1)) and (not selecting_bits(0)));
    output_bits(1) <= input_bit and ((not selecting_bits(3)) and (not selecting_bits(2)) and (not selecting_bits(1)) and (selecting_bits(0)));
    output_bits(0) <= input_bit and ((not selecting_bits(3)) and (not selecting_bits(2)) and (not selecting_bits(1)) and (not selecting_bits(0)));
end Dataflow;
