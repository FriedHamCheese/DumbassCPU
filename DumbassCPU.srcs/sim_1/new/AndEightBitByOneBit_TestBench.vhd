library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AndEightBitByOneBit_TestBench is
end AndEightBitByOneBit_TestBench;

architecture Behavioral of AndEightBitByOneBit_TestBench is

component AndEightBitByOneBit is Port(
    eight_bits: in std_logic_vector(7 downto 0);
    one_bit: in std_logic;
    output: out std_logic_vector(7 downto 0)
);
end component;

signal eight_bits, output : std_logic_vector(7 downto 0);
signal one_bit : std_logic;

begin

module: AndEightBitByOneBit port map(
	eight_bits => eight_bits,
	one_bit => one_bit,
	output => output
);

process is
begin
	eight_bits <= "10101101";
	one_bit <= '0';
	wait for 20ns;
	assert(output = "00000000");
	
	eight_bits <= "10101101";
	one_bit <= '1';
	wait for 20ns;
	assert(output = "10101101");	
	
	eight_bits <= "00010010";
	one_bit <= '1';
	wait for 20ns;
	assert(output = "00010010");	
	
	eight_bits <= "00010010";
	one_bit <= '0';
	wait for 20ns;
	assert(output = "00000000");
	
	wait;
end process;

end Behavioral;