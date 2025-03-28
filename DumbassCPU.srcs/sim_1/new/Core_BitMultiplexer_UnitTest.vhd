library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_BitMultiplexer_UnitTest is
--  Port ( );
end Core_BitMultiplexer_UnitTest;

architecture Behavioral of Core_BitMultiplexer_UnitTest is

component Core_BitMultiplexer is Port(
    input_bits: in std_logic_vector (63 downto 0);
    selecting_bits: in std_Logic_vector (7 downto 0);
    selected_bit: out std_logic
);
end component;

signal selecting_bits: std_logic_vector(7 downto 0);
signal selected_bit: std_logic;

constant testing_bits : std_logic_vector(63 downto 0) := "0011110011101111010001100110010101011110110100111101000101111101";

begin
    selector: Core_BitMultiplexer port map(testing_bits, selecting_bits, selected_bit);
    proc: process is
    begin
        selecting_bits <= "00000000";
        wait for 20ns;
        assert(selected_bit = '1'); 
        
        selecting_bits <= "00101010";
        wait for 20ns;
        assert(selected_bit = '1');
		
        selecting_bits <= "00101001";
        wait for 20ns;
        assert(selected_bit = '1');
		
        selecting_bits <= "00100100";
        wait for 20ns;
        assert(selected_bit = '0');

        selecting_bits <= "00111001";
        wait for 20ns;
        assert(selected_bit = '0');
		
        selecting_bits <= "00100111";
        wait for 20ns;
        assert(selected_bit = '0');
        wait;
    end process proc;

end Behavioral;
