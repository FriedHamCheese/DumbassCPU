----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2025 01:20:49 PM
-- Design Name: 
-- Module Name: AndEightBitByOneBit - Dataflow
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

entity AndEightBitByOneBit is Port(
    eight_bits: in std_logic_vector(7 downto 0);
    one_bit: in std_logic;
    output: out std_logic_vector(7 downto 0)
);
end AndEightBitByOneBit;

architecture Dataflow of AndEightBitByOneBit is

begin
    output(0) <= one_bit and eight_bits(0);
    output(1) <= one_bit and eight_bits(1);
    output(2) <= one_bit and eight_bits(2);
    output(3) <= one_bit and eight_bits(3);
    output(4) <= one_bit and eight_bits(4);
    output(5) <= one_bit and eight_bits(5);
    output(6) <= one_bit and eight_bits(6);
    output(7) <= one_bit and eight_bits(7);
end Dataflow;
