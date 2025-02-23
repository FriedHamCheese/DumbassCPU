library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OneBitDFlipFlop is Port(
    bit_in, 
    rising_edge_clk,
    overwrite
    : in std_logic;
    bit_out: out std_logic
);
end OneBitDFlipFlop;

architecture Behavioral of OneBitDFlipFlop is

signal stored_bit, overwrite_as: std_logic := '0';

begin
    bit_out <= stored_bit;
    overwrite_as <= (overwrite and bit_in) or ((not overwrite) and stored_bit);
    
    proc: process(rising_edge_clk, bit_in) is
    begin
        if (rising_edge(rising_edge_clk)) then
            stored_bit <= overwrite_as;
        end if;
    end process proc;
end Behavioral;
