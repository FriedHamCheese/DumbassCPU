library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ByteComparator is Port(
	a, b: in std_logic_vector (7 downto 0);
	equal, greater, lesser
	: out std_logic
);
end ByteComparator;

architecture Structural of ByteComparator is

component BitComparator is Port(
	a, b, 
	was_equal, 
	was_greater, 
	was_lesser
	: in std_logic;
	equal, greater, lesser
	: out std_logic
);
end component;

signal 
	bits_equal,
	bits_greater,
	bits_lesser
: std_logic_vector(7 downto 0) := "00000000";

signal
	internal_equal
: std_logic := '0';

begin

compare_bit_7: BitComparator port map(
	a => a(7), b => b(7), 
	was_equal => '1',
	was_greater => '0',
	was_lesser => '0',
	equal => bits_equal(7), 
	greater => bits_greater(7), 
	lesser => bits_lesser(7)
);

compare_bit_6: BitComparator port map(
	a => a(6), b => b(6), 
	was_equal => bits_equal(7),
	was_greater => bits_greater(7),
	was_lesser => bits_lesser(7),
	equal => bits_equal(6), 
	greater => bits_greater(6), 
	lesser => bits_lesser(6)
);

compare_bit_5: BitComparator port map(
	a => a(5), b => b(5), 
	was_equal => bits_equal(6),
	was_greater => bits_greater(6),
	was_lesser => bits_lesser(6),
	equal => bits_equal(5), 
	greater => bits_greater(5), 
	lesser => bits_lesser(5)
);

compare_bit_4: BitComparator port map(
	a => a(4), b => b(4), 
	was_equal => bits_equal(5),
	was_greater => bits_greater(5),
	was_lesser => bits_lesser(5),
	equal => bits_equal(4), 
	greater => bits_greater(4), 
	lesser => bits_lesser(4)
);

compare_bit_3: BitComparator port map(
	a => a(3), b => b(3), 
	was_equal => bits_equal(4),
	was_greater => bits_greater(4),
	was_lesser => bits_lesser(4),
	equal => bits_equal(3), 
	greater => bits_greater(3), 
	lesser => bits_lesser(3)
);

compare_bit_2: BitComparator port map(
	a => a(2), b => b(2), 
	was_equal => bits_equal(3),
	was_greater => bits_greater(3),
	was_lesser => bits_lesser(3),
	equal => bits_equal(2), 
	greater => bits_greater(2), 
	lesser => bits_lesser(2)
);

compare_bit_1: BitComparator port map(
	a => a(1), b => b(1), 
	was_equal => bits_equal(2),
	was_greater => bits_greater(2),
	was_lesser => bits_lesser(2),
	equal => bits_equal(1), 
	greater => bits_greater(1), 
	lesser => bits_lesser(1)
);

compare_bit_0: BitComparator port map(
	a => a(0), b => b(0), 
	was_equal => bits_equal(1),
	was_greater => bits_greater(1),
	was_lesser => bits_lesser(1),
	equal => bits_equal(0),
	greater => bits_greater(0), 
	lesser => bits_lesser(0)
);

equal <= bits_equal(0);
greater <= bits_greater(0);
lesser <= bits_lesser(0);

end Structural;