library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_ByteMultiplexer is Port(
    instruction_0_in, 
    instruction_1_in, 
    instruction_2_in, 
    instruction_3_in, 
    instruction_4_in, 
    instruction_5_in, 
    instruction_6_in,
    instruction_7_in,
    instruction_8_in,
    instruction_9_in,
    instruction_10_in,
    instruction_11_in,
    instruction_12_in,
    instruction_13_in,
    instruction_14_in,
    instruction_15_in 
    : in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(3 downto 0);
    selected_byte: out std_logic_vector(7 downto 0)
);
end Core_ByteMultiplexer;

architecture Structural of Core_ByteMultiplexer is

component Core_BitMultiplexer is Port(
    input_bits: in std_logic_vector (15 downto 0);
    selecting_bits: in std_Logic_vector (3 downto 0);
    selected_bit: out std_logic
);
end component;

type GroupedByInstruction is array(15 downto 0) of std_logic_vector(7 downto 0);
signal grouped_by_instruction: GroupedByInstruction;

type GroupedByBitOrder is array(7 downto 0) of std_logic_vector(15 downto 0);
signal grouped_by_bit_order: GroupedByBitOrder;

begin
	grouped_by_instruction(15) <= instruction_15_in;
	grouped_by_instruction(14) <= instruction_14_in;
	grouped_by_instruction(13) <= instruction_13_in;
	grouped_by_instruction(12) <= instruction_12_in;
	grouped_by_instruction(11) <= instruction_11_in;
	grouped_by_instruction(10) <= instruction_10_in;
	grouped_by_instruction(9) <= instruction_9_in;
	grouped_by_instruction(8) <= instruction_8_in;
	grouped_by_instruction(7) <= instruction_7_in;
	grouped_by_instruction(6) <= instruction_6_in;
	grouped_by_instruction(5) <= instruction_5_in;
	grouped_by_instruction(4) <= instruction_4_in;
	grouped_by_instruction(3) <= instruction_3_in;
	grouped_by_instruction(2) <= instruction_2_in;
	grouped_by_instruction(1) <= instruction_1_in;
	grouped_by_instruction(0) <= instruction_0_in;

    -- not coding 256*8 lines ok, vhdl sucks more than wiring shit up
	proc: process(grouped_by_instruction) is
	begin
		for instruction in 0 to 15 loop
			for gbit in 0 to 7 loop
				grouped_by_bit_order(gbit)(instruction) <= grouped_by_instruction(instruction)(gbit);
			end loop;
		end loop;
	end process proc;
	
	bit_7: Core_BitMultiplexer port map (grouped_by_bit_order(7), selecting_bits, selected_byte(7));
	bit_6: Core_BitMultiplexer port map (grouped_by_bit_order(6), selecting_bits, selected_byte(6));
	bit_5: Core_BitMultiplexer port map (grouped_by_bit_order(5), selecting_bits, selected_byte(5));
	bit_4: Core_BitMultiplexer port map (grouped_by_bit_order(4), selecting_bits, selected_byte(4));
	bit_3: Core_BitMultiplexer port map (grouped_by_bit_order(3), selecting_bits, selected_byte(3));
	bit_2: Core_BitMultiplexer port map (grouped_by_bit_order(2), selecting_bits, selected_byte(2));
	bit_1: Core_BitMultiplexer port map (grouped_by_bit_order(1), selecting_bits, selected_byte(1));
	bit_0: Core_BitMultiplexer port map (grouped_by_bit_order(0), selecting_bits, selected_byte(0));
	
end Structural;
