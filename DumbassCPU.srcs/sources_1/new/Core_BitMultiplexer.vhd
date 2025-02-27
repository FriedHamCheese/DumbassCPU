library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_BitMultiplexer is Port(
    input_bits: in std_logic_vector (63 downto 0);
    selecting_bits: in std_Logic_vector (7 downto 0);
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

signal stage_1_63_to_0_input_bits: std_logic_vector(7 downto 0) := "00000000";

signal stage_2_255_to_0_input_bits: std_logic_vector (7 downto 0) := "00000000";
signal stage_2_255_to_0_selecting_bits: std_logic_vector(2 downto 0) := "000";

begin
    stage_0_7_to_0_mux:     EightBitToOneBitMultiplexer port map(input_bits(7 downto 0), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(0));
    stage_0_15_to_8_mux:    EightBitToOneBitMultiplexer port map(input_bits(15 downto 8), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(1));
    stage_0_23_to_16_mux:   EightBitToOneBitMultiplexer port map(input_bits(23 downto 16), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(2));
    stage_0_31_to_24_mux:   EightBitToOneBitMultiplexer port map(input_bits(31 downto 24), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(3));
    stage_0_39_to_32_mux:   EightBitToOneBitMultiplexer port map(input_bits(39 downto 32), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(4));
    stage_0_47_to_40_mux:   EightBitToOneBitMultiplexer port map(input_bits(47 downto 40), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(5));
    stage_0_55_to_48_mux:   EightBitToOneBitMultiplexer port map(input_bits(55 downto 48), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(6));
    stage_0_63_to_56_mux:   EightBitToOneBitMultiplexer port map(input_bits(63 downto 56), selecting_bits(2 downto 0), stage_1_63_to_0_input_bits(7));

    stage_1_63_to_0_mux:    EightBitToOneBitMultiplexer port map(stage_1_63_to_0_input_bits, selecting_bits(5 downto 3), stage_2_255_to_0_input_bits(0));

    stage_2_255_to_0_selecting_bits(1) <= selecting_bits(7);
    stage_2_255_to_0_selecting_bits(0) <= selecting_bits(6);
    stage_2_255_to_0_mux:   EightBitToOneBitMultiplexer port map(stage_2_255_to_0_input_bits, stage_2_255_to_0_selecting_bits, selected_bit);

end Structural;
