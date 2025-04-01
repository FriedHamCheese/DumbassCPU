library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EightBitToOneBitMultiplexer_TestBench is
end EightBitToOneBitMultiplexer_TestBench;

architecture Behavioral of EightBitToOneBitMultiplexer_TestBench is

component EightBitToOneBitMultiplexer is Port(
    input_bits: in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(2 downto 0);
    selected_bit: out std_logic
);
end component;

signal selecting_bits: std_logic_vector(2 downto 0);
signal selected_bit: std_logic;

begin
	multiplexer: EightBitToOneBitMultiplexer port map(
		input_bits => "00011011",
		selecting_bits => selecting_bits,
		selected_bit => selected_bit
	);
	
	process is
	begin
		selecting_bits <= "000";
		wait for 20ns;
		assert(selected_bit = '1');
		
		selecting_bits <= "001";
		wait for 20ns;
		assert(selected_bit = '1');

		selecting_bits <= "010";
		wait for 20ns;
		assert(selected_bit = '0');
		
		selecting_bits <= "011";
		wait for 20ns;
		assert(selected_bit = '1');
		
		selecting_bits <= "100";
		wait for 20ns;
		assert(selected_bit = '1');
		
		selecting_bits <= "101";
		wait for 20ns;
		assert(selected_bit = '0');

		selecting_bits <= "110";
		wait for 20ns;
		assert(selected_bit = '0');
		
		selecting_bits <= "111";
		wait for 20ns;
		assert(selected_bit = '0');
		
		selecting_bits <= "000";
		wait for 20ns;
		wait;
	end process;
end Behavioral;