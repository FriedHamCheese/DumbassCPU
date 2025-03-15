library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_ByteMultiplexer is Port(
    byte_0_in, byte_1_in, byte_2_in, byte_3_in, byte_4_in, byte_5_in, byte_6_in, byte_7_in,
    byte_8_in, byte_9_in, byte_10_in, byte_11_in, byte_12_in, byte_13_in, byte_14_in, byte_15_in,
    byte_16_in, byte_17_in, byte_18_in, byte_19_in, byte_20_in, byte_21_in, byte_22_in, byte_23_in,
    byte_24_in, byte_25_in, byte_26_in, byte_27_in, byte_28_in, byte_29_in, byte_30_in, byte_31_in,
    byte_32_in, byte_33_in, byte_34_in, byte_35_in, byte_36_in, byte_37_in, byte_38_in, byte_39_in,
    byte_40_in, byte_41_in, byte_42_in, byte_43_in, byte_44_in, byte_45_in, byte_46_in, byte_47_in,
    byte_48_in, byte_49_in, byte_50_in, byte_51_in, byte_52_in, byte_53_in, byte_54_in, byte_55_in,
    byte_56_in, byte_57_in, byte_58_in, byte_59_in, byte_60_in, byte_61_in, byte_62_in, byte_63_in
    : in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(7 downto 0);
    selected_byte: out std_logic_vector(7 downto 0)
);
end Core_ByteMultiplexer;

architecture Structural of Core_ByteMultiplexer is

constant LAST_byte: integer := 63;

component Core_BitMultiplexer is Port(
    input_bits: in std_logic_vector (LAST_byte downto 0);
    selecting_bits: in std_Logic_vector (7 downto 0);
    selected_bit: out std_logic
);
end component;


type GroupedBybyte is array(LAST_byte downto 0) of std_logic_vector(7 downto 0);
signal grouped_by_byte: GroupedBybyte;

type GroupedByBitOrder is array(7 downto 0) of std_logic_vector(LAST_byte downto 0);
signal grouped_by_bit_order: GroupedByBitOrder;

begin
	grouped_by_byte(LAST_byte) <= byte_63_in;
	grouped_by_byte(62) <= byte_62_in;
	grouped_by_byte(61) <= byte_61_in;
	grouped_by_byte(60) <= byte_60_in;

	grouped_by_byte(59) <= byte_59_in;
	grouped_by_byte(58) <= byte_58_in;
	grouped_by_byte(57) <= byte_57_in;
	grouped_by_byte(56) <= byte_56_in;
	grouped_by_byte(55) <= byte_55_in;
	grouped_by_byte(54) <= byte_54_in;
	grouped_by_byte(53) <= byte_53_in;
	grouped_by_byte(52) <= byte_52_in;
	grouped_by_byte(51) <= byte_51_in;
	grouped_by_byte(50) <= byte_50_in;

	grouped_by_byte(49) <= byte_49_in;
	grouped_by_byte(48) <= byte_48_in;
	grouped_by_byte(47) <= byte_47_in;
	grouped_by_byte(46) <= byte_46_in;
	grouped_by_byte(45) <= byte_45_in;
	grouped_by_byte(44) <= byte_44_in;
	grouped_by_byte(43) <= byte_43_in;
	grouped_by_byte(42) <= byte_42_in;
	grouped_by_byte(41) <= byte_41_in;
	grouped_by_byte(40) <= byte_40_in;

	grouped_by_byte(39) <= byte_39_in;
	grouped_by_byte(38) <= byte_38_in;
	grouped_by_byte(37) <= byte_37_in;
	grouped_by_byte(36) <= byte_36_in;
	grouped_by_byte(35) <= byte_35_in;
	grouped_by_byte(34) <= byte_34_in;
	grouped_by_byte(33) <= byte_33_in;
	grouped_by_byte(32) <= byte_32_in;
	grouped_by_byte(31) <= byte_31_in;
	grouped_by_byte(30) <= byte_30_in;

	grouped_by_byte(29) <= byte_29_in;
	grouped_by_byte(28) <= byte_28_in;
	grouped_by_byte(27) <= byte_27_in;
	grouped_by_byte(26) <= byte_26_in;
	grouped_by_byte(25) <= byte_25_in;
	grouped_by_byte(24) <= byte_24_in;
	grouped_by_byte(23) <= byte_23_in;
	grouped_by_byte(22) <= byte_22_in;
	grouped_by_byte(21) <= byte_21_in;
	grouped_by_byte(20) <= byte_20_in;

	grouped_by_byte(19) <= byte_19_in;
	grouped_by_byte(18) <= byte_18_in;
	grouped_by_byte(17) <= byte_17_in;
	grouped_by_byte(16) <= byte_16_in;
	grouped_by_byte(15) <= byte_15_in;
	grouped_by_byte(14) <= byte_14_in;
	grouped_by_byte(13) <= byte_13_in;
	grouped_by_byte(12) <= byte_12_in;
	grouped_by_byte(11) <= byte_11_in;
	grouped_by_byte(10) <= byte_10_in;
    
	grouped_by_byte(9) <= byte_9_in;
	grouped_by_byte(8) <= byte_8_in;
	grouped_by_byte(7) <= byte_7_in;
	grouped_by_byte(6) <= byte_6_in;
	grouped_by_byte(5) <= byte_5_in;
	grouped_by_byte(4) <= byte_4_in;
	grouped_by_byte(3) <= byte_3_in;
	grouped_by_byte(2) <= byte_2_in;
	grouped_by_byte(1) <= byte_1_in;
	grouped_by_byte(0) <= byte_0_in;

    -- not coding 256*8 lines ok, vhdl sucks more than wiring shit up
	proc: process(grouped_by_byte) is
	begin
		for byte in 0 to LAST_byte loop
			for gbit in 0 to 7 loop
				grouped_by_bit_order(gbit)(byte) <= grouped_by_byte(byte)(gbit);
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
