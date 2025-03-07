library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Core_ByteMultiplexer_UnitTest is
--  Port ( );
end Core_ByteMultiplexer_UnitTest;

architecture Behavioral of Core_ByteMultiplexer_UnitTest is

component Core_ByteMultiplexer is Port(
    instruction_0_in, 
    instruction_1_in, 
    instruction_2_in, 
    instruction_3_in, 
    instruction_4_in, 
    instruction_5_in, 
    instruction_6_in,
    instruction_7_in,
    instruction_8_in,
    instruction_9_in,
    instruction_10_in,
    instruction_11_in,
    instruction_12_in,
    instruction_13_in,
    instruction_14_in,
    instruction_15_in 
    : in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(7 downto 0);
    selected_byte: out std_logic_vector(7 downto 0)
);
end component;

signal selecting_bits: std_logic_vector(7 downto 0);
signal selected_byte: std_logic_vector(7 downto 0);

begin
    selector: Core_ByteMultiplexer port map(
        "00000001",
        "00000010",
        "00000100",
        "00001000",
        "00010000",
        "00100000",
        "01000000",
        "10000000",
        --^=7-0
        "00010001",
        "00100010",
        "01000100",
        "10001000",
        "10101010",
        "11011010",
        "11111110",
        "11111111",
        selecting_bits,
        selected_byte
    );
    
    proc: process is
    begin
        assert(false = true)
        report "---- Core_ByteMultiplexer_UnitTest Begin ----"
        severity note;
        
        selecting_bits <= "00000000";
        wait for 20ns;
        assert(selected_byte = "00000001")
        report "Core_ByteMultiplexer_UnitTest: failed case 0"
        severity error;
        
        assert(false = true)
        report "---- Core_ByteMultiplexer_UnitTest End ----"
        severity note;
        wait;
    end process proc;

end Behavioral;
