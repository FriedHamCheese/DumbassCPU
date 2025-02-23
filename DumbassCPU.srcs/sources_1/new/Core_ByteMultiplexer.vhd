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
    instruction_15_in,
    instruction_16_in,
    instruction_17_in,
    instruction_18_in,
    instruction_19_in,
    
    instruction_20_in,
    instruction_21_in,
    instruction_22_in,
    instruction_23_in,
    instruction_24_in,
    instruction_25_in,
    instruction_26_in,
    instruction_27_in,
    instruction_28_in,
    instruction_29_in,
    
    instruction_30_in,
    instruction_31_in,
    instruction_32_in,
    instruction_33_in,
    instruction_34_in,
    instruction_35_in,
    instruction_36_in,
    instruction_37_in,
    instruction_38_in,
    instruction_39_in,
    
    instruction_40_in,
    instruction_41_in,
    instruction_42_in,
    instruction_43_in,
    instruction_44_in,
    instruction_45_in,
    instruction_46_in,
    instruction_47_in,
    instruction_48_in,
    instruction_49_in,
    
    instruction_50_in,
    instruction_51_in,
    instruction_52_in,
    instruction_53_in,
    instruction_54_in,
    instruction_55_in,
    instruction_56_in,
    instruction_57_in,
    instruction_58_in,
    instruction_59_in,

    instruction_60_in,
    instruction_61_in,
    instruction_62_in,
    instruction_63_in    
    : in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(7 downto 0);
    selected_byte: out std_logic_vector(7 downto 0)
);
end Core_ByteMultiplexer;

architecture Structural of Core_ByteMultiplexer is

constant LAST_INSTRUCTION: integer := 63;

component Core_BitMultiplexer is Port(
    input_bits: in std_logic_vector (LAST_INSTRUCTION downto 0);
    selecting_bits: in std_Logic_vector (7 downto 0);
    selected_bit: out std_logic
);
end component;


type GroupedByInstruction is array(LAST_INSTRUCTION downto 0) of std_logic_vector(7 downto 0);
signal grouped_by_instruction: GroupedByInstruction;

type GroupedByBitOrder is array(7 downto 0) of std_logic_vector(LAST_INSTRUCTION downto 0);
signal grouped_by_bit_order: GroupedByBitOrder;

begin
	grouped_by_instruction(LAST_INSTRUCTION) <= instruction_63_in;
	grouped_by_instruction(62) <= instruction_62_in;
	grouped_by_instruction(61) <= instruction_61_in;
	grouped_by_instruction(60) <= instruction_60_in;

	grouped_by_instruction(59) <= instruction_59_in;
	grouped_by_instruction(58) <= instruction_58_in;
	grouped_by_instruction(57) <= instruction_57_in;
	grouped_by_instruction(56) <= instruction_56_in;
	grouped_by_instruction(55) <= instruction_55_in;
	grouped_by_instruction(54) <= instruction_54_in;
	grouped_by_instruction(53) <= instruction_53_in;
	grouped_by_instruction(52) <= instruction_52_in;
	grouped_by_instruction(51) <= instruction_51_in;
	grouped_by_instruction(50) <= instruction_50_in;

	grouped_by_instruction(49) <= instruction_49_in;
	grouped_by_instruction(48) <= instruction_48_in;
	grouped_by_instruction(47) <= instruction_47_in;
	grouped_by_instruction(46) <= instruction_46_in;
	grouped_by_instruction(45) <= instruction_45_in;
	grouped_by_instruction(44) <= instruction_44_in;
	grouped_by_instruction(43) <= instruction_43_in;
	grouped_by_instruction(42) <= instruction_42_in;
	grouped_by_instruction(41) <= instruction_41_in;
	grouped_by_instruction(40) <= instruction_40_in;

	grouped_by_instruction(39) <= instruction_39_in;
	grouped_by_instruction(38) <= instruction_38_in;
	grouped_by_instruction(37) <= instruction_37_in;
	grouped_by_instruction(36) <= instruction_36_in;
	grouped_by_instruction(35) <= instruction_35_in;
	grouped_by_instruction(34) <= instruction_34_in;
	grouped_by_instruction(33) <= instruction_33_in;
	grouped_by_instruction(32) <= instruction_32_in;
	grouped_by_instruction(31) <= instruction_31_in;
	grouped_by_instruction(30) <= instruction_30_in;

	grouped_by_instruction(29) <= instruction_29_in;
	grouped_by_instruction(28) <= instruction_28_in;
	grouped_by_instruction(27) <= instruction_27_in;
	grouped_by_instruction(26) <= instruction_26_in;
	grouped_by_instruction(25) <= instruction_25_in;
	grouped_by_instruction(24) <= instruction_24_in;
	grouped_by_instruction(23) <= instruction_23_in;
	grouped_by_instruction(22) <= instruction_22_in;
	grouped_by_instruction(21) <= instruction_21_in;
	grouped_by_instruction(20) <= instruction_20_in;

	grouped_by_instruction(19) <= instruction_19_in;
	grouped_by_instruction(18) <= instruction_18_in;
	grouped_by_instruction(17) <= instruction_17_in;
	grouped_by_instruction(16) <= instruction_16_in;
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
		for instruction in 0 to LAST_INSTRUCTION loop
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
