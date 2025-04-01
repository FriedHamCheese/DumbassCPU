library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BitComparator_TestBench is
--  Port ( );
end BitComparator_TestBench;

architecture Behavioral of BitComparator_TestBench is

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
    a, b,
    was_equal, was_greater, was_lesser,
    equal, greater, lesser
: std_logic;

begin
comparator: BitComparator port map(
    a => a, b => b, 
    was_equal => was_equal, 
    was_greater => was_greater, 
    was_lesser => was_lesser, 
    equal => equal, 
    greater => greater, 
    lesser => lesser
);
    process is
    begin
        was_equal <= '0';
        was_greater <= '1';
        was_lesser <= '0';
        a <= '1';
        b <= '1';
        wait for 100ns;
        assert(equal = '0' and greater = '1' and lesser = '0');
        
        was_equal <= '0';
        was_greater <= '0';
        was_lesser <= '1';
        a <= '1';
        b <= '0';
        wait for 100ns; 
        assert(equal = '0' and greater = '0' and lesser = '1');       
        
        was_equal <= '0';
        was_greater <= '0';
        was_lesser <= '1';
        a <= '1';
        b <= '0';
        wait for 100ns;
        assert(equal = '0' and greater = '0' and lesser = '1');          
        
        was_equal <= '1';
        was_greater <= '0';
        was_lesser <= '0';
        a <= '0';
        b <= '0';
        wait for 100ns;
        assert(equal = '1' and greater = '0' and lesser = '0');     
        
        was_equal <= '1';
        was_greater <= '0';
        was_lesser <= '0';
        a <= '1';
        b <= '0';
        wait for 100ns;
        assert(equal = '0' and greater = '1' and lesser = '0');         
        
        was_equal <= '1';
        was_greater <= '0';
        was_lesser <= '0';
        a <= '0';
        b <= '1';
        wait for 100ns;
        assert(equal = '0' and greater = '0' and lesser = '1');
        wait;
    end process;

end Behavioral;
