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

begin
    selector: Core_BitMultiplexer port map("1010101010101010101010101010101010101010101010101010101010101010", selecting_bits, selected_bit);
    proc: process is
    begin
        assert(false = true)
        report "---- Core_BitMultiplexer_UnitTest Begin ----"
        severity note;
        
        selecting_bits <= "00000000";
        wait for 20ns;
        assert(selected_bit = '0')
        report "Core_BitMultiplexer_UnitTest: failed case 0 ----"
        severity error;    
        
        selecting_bits <= "00000001";
        wait for 20ns;
        assert(selected_bit = '1')
        report "Core_BitMultiplexer_UnitTest: failed case 1 ----"
        severity error;    
        
        assert(false = true)
        report "---- Core_BitMultiplexer_UnitTest End ----"
        severity note;
        wait;
    end process proc;

end Behavioral;
