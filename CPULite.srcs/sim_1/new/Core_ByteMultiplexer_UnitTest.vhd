library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_ByteMultiplexer_UnitTest is
--  Port ( );
end Core_ByteMultiplexer_UnitTest;

architecture Behavioral of Core_ByteMultiplexer_UnitTest is

component Core_ByteMultiplexer is Port(
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
end component;

signal selecting_bits: std_logic_vector(7 downto 0);
signal selected_byte: std_logic_vector(7 downto 0);

begin
	selector: Core_ByteMultiplexer port map(
		"00000000", "00000000", "01010101", "00000000", "00000000", "11011001", "00000000", "00000000",
		"00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
		"00000000", "10010010", "00000000", "10101001", "00000000", "10101010", "00000000", "00001111",
		"00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
		"00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",
		"11010010", "00000000", "00000000", "00000000", "00000000", "00000000", "10101010", "00000000",
		"00000000", "00000000", "10000001", "00000000", "00000000", "00000000", "00000000", "00000000",
		"00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "11111111", "00000000",
		selecting_bits,
		selected_byte
	);
    
    process is
    begin
		selecting_bits <= "00000010";
		wait for 20ns;
		assert(selected_byte = "01010101");
		
		selecting_bits <= "00010101";
		wait for 20ns;
		assert(selected_byte = "10101010");

		selecting_bits <= "00110110";
		wait for 20ns;
		assert(selected_byte = "00000000");
		
		selecting_bits <= "00111110";
		wait for 20ns;
		assert(selected_byte = "11111111");
		
		selecting_bits <= "00110010";
		wait for 20ns;
		assert(selected_byte = "10000001");
		wait;
    end process;

end Behavioral;
