library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ByteComparator_TestBench is
end ByteComparator_TestBench;

architecture Behavioral of ByteComparator_TestBench is

component ByteComparator is Port(
	a, b: in std_logic_vector (7 downto 0);
	equal, greater, lesser
: out std_logic
);
end component;

signal a, b : std_logic_vector(7 downto 0);
signal equal, greater, lesser : std_logic;

begin
comparator: ByteComparator port map(a => a, b => b, equal => equal, greater => greater, lesser => lesser);

process is
begin
    a <= "00000000";
    b <= "00000000";
    wait for 100ns;
    assert(equal = '1' and greater = '0' and lesser = '0');
    
    a <= "11111111";
    b <= "11111111";
    wait for 100ns;
    assert(equal = '1' and greater = '0' and lesser = '0');

    a <= "00111011";
    b <= "01010000";
    wait for 100ns;
    assert(equal = '0' and greater = '0' and lesser = '1');
    
    a <= "11000011";
    b <= "01101011";
    wait for 100ns;
    assert(equal = '0' and greater = '1' and lesser = '0');  
    
    a <= "00001100";
    b <= "01100100";
    wait for 100ns;
    assert(equal = '0' and greater = '0' and lesser = '1');  
    
    a <= "00011100";
    b <= "10110111";
    wait for 100ns;
    assert(equal = '0' and greater = '0' and lesser = '1');        
    wait;
end process;

end Behavioral;
