library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BitComparator is Port(
	a, b, 
	was_equal, 
	was_greater, 
	was_lesser
	: in std_logic;
	equal, greater, lesser
	: out std_logic
);
end BitComparator;

architecture Dataflow of BitComparator is

begin

equal <= was_equal and ((a and b) or (not (a or b)));
greater <= (was_equal and (a and (not b))) or was_greater;
lesser <= (was_equal and ((not a) and b)) or was_lesser;

end Dataflow;