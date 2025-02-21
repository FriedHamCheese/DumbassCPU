----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2025 07:37:04 PM
-- Design Name: 
-- Module Name: InstructionOutputSelector - Structural
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

entity InstructionBitOutputSelector is Port(
    input_bits: in std_logic_vector (15 downto 0);
    selecting_bits: in std_Logic_vector (3 downto 0);
    selected_bit: out std_logic
);
end InstructionBitOutputSelector;

architecture Structural of InstructionBitOutputSelector is

component EightBitToOneBitMultiplexer is Port(
    input_bits: in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(2 downto 0);
    selected_bit: out std_logic
);
end component;

signal fifteenth_to_zeroth_selecting_bits: std_logic_vector(2 downto 0) := "000";
signal fifteenth_to_zeroth_input_bits: std_logic_vector(7 downto 0) := "00000000";

begin
    fifteenth_to_zeroth_selecting_bits(0) <= selecting_bits(3); 
    
    fifteenth_to_eighth_bit_multiplexer: EightBitToOneBitMultiplexer port map(
        input_bits => input_bits(15 downto 8), 
        selecting_bits => selecting_bits(2 downto 0), 
        selected_bit => fifteenth_to_zeroth_input_bits(1)
    );
    seventh_to_zeroth_bit_multiplexer: EightBitToOneBitMultiplexer port map(
        input_bits => input_bits(7 downto 0), 
        selecting_bits => selecting_bits(2 downto 0), 
        selected_bit => fifteenth_to_zeroth_input_bits(0)
    );
    fifteenth_to_zeroth_bit_multiplexer: EightBitToOneBitMultiplexer port map(
        input_bits => fifteenth_to_zeroth_input_bits, 
        selecting_bits => fifteenth_to_zeroth_selecting_bits, 
        selected_bit => selected_bit
    ); 

end Structural;
