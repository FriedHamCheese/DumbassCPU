----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 05:40:06 PM
-- Design Name: 
-- Module Name: OneBitDFlipFlop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
