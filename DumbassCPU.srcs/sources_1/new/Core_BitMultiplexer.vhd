library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_BitMultiplexer is Port(
    input_bits: in std_logic_vector (15 downto 0);
    selecting_bits: in std_Logic_vector (3 downto 0);
    selected_bit: out std_logic
);
end Core_BitMultiplexer;

architecture Structural of Core_BitMultiplexer is

component EightBitToOneBitMultiplexer is Port(
    input_bits: in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(2 downto 0);
    selected_bit: out std_logic
);
end component;

signal stage_1_fifteenth_to_zeroth_selecting_bits: std_logic_vector(2 downto 0) := "000";
signal stage_1_fifteenth_to_zeroth_input_bits: std_logic_vector(7 downto 0) := "00000000";

begin
    fifteenth_to_zeroth_selecting_bits(0) <= selecting_bits(3); 
    
    stage_0_fifteenth_to_eighth_bit_multiplexer: EightBitToOneBitMultiplexer port map(
        input_bits => input_bits(15 downto 8), 
        selecting_bits => selecting_bits(2 downto 0), 
        selected_bit => stage_1_fifteenth_to_zeroth_input_bits(1)
    );
    stage_0_seventh_to_zeroth_bit_multiplexer: EightBitToOneBitMultiplexer port map(
        input_bits => input_bits(7 downto 0), 
        selecting_bits => selecting_bits(2 downto 0), 
        selected_bit => stage_1_fifteenth_to_zeroth_input_bits(0)
    );
    stage_1_fifteenth_to_zeroth_bit_multiplexer: EightBitToOneBitMultiplexer port map(
        input_bits => stage_1_fifteenth_to_zeroth_input_bits, 
        selecting_bits => stage_1_fifteenth_to_zeroth_selecting_bits, 
        selected_bit => selected_bit
    );

end Structural;
