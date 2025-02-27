library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OneBitDFlipFlop_UnitTest is
end OneBitDFlipFlop_UnitTest;

architecture Behavioral of OneBitDFlipFlop_UnitTest is

component OneBitDFlipFlop is Port(
    bit_in, 
    rising_edge_clk,
    overwrite
    : in std_logic;
    bit_out: out std_logic
);
end component;

signal bit_in, overwrite, bit_out: std_logic := '0';
signal clk: std_logic;

begin
    ff: OneBitDFlipFlop port map(bit_in, clk, overwrite, bit_out);

    proc: process is
    begin
        assert(false = true)
        report "---- OneBitDFlipFlop_UnitTest begin ----"
        severity note;
            
        bit_in <= '1';
        overwrite <= '1';
        wait for 110ns;        
        assert(bit_out = '1')
        report "Failed to overwrite."
        severity error;

        bit_in <= '0';
        overwrite <= '0';
        wait for 100ns;
        assert(bit_out = '1')
        report "Failed to not overwrite."
        severity error;
        
        overwrite <= '1';
        wait for 100ns;
        assert(bit_out = '0')
        report "Failed to overwrite."
        severity error;
        
        assert(false = true)
        report "---- OneBitDFlipFlop_UnitTest end ----"
        severity note;
        wait;
    end process proc;

end Behavioral;