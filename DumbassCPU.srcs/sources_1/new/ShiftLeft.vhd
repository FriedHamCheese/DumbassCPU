----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2025 03:38:50 PM
-- Design Name: 
-- Module Name: ShiftLeft - Dataflow
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

entity ShiftLeft is
    Port ( Input : in std_logic_vector(7 downto 0);
           Count : in std_logic_vector(7 downto 0);
           Output : out std_logic_vector(7 downto 0));
end ShiftLeft;

architecture dataflow of ShiftLeft is

component AndEightBitByOneBit is Port(
    eight_bits: in std_logic_vector(7 downto 0);
    one_bit: in std_logic;
    output: out std_logic_vector(7 downto 0)
);
end component;

signal ShiftBy : std_logic_vector(7 downto 0);
signal Shifted0Bits, Shifted1Bits, Shifted2Bits, Shifted3Bits, Shifted4Bits, Shifted5Bits, Shifted6Bits, Shifted7Bits : std_logic_vector(7 downto 0);
signal OutputSum : std_logic_vector(7 downto 0);
signal UseSum : std_logic := '0';
begin

ShiftBy(0) <= not Count(0) and not Count(1) and not Count(2);
ShiftBy(1) <= Count(0) and not Count(1) and not Count(2);
ShiftBy(2) <= not Count(0) and Count(1) and not Count(2);
ShiftBy(3) <= Count(0) and Count(1) and not Count(2);
ShiftBy(4) <= not Count(0) and not Count(1) and Count(2);
ShiftBy(5) <= Count(0) and not Count(1) and Count(2);
ShiftBy(6) <= not Count(0) and Count(1) and Count(2);
ShiftBy(7) <= Count(0) and Count(1) and Count(2);

Shifted0Bits(0) <= ShiftBy(0) and Input(0);
Shifted0Bits(1) <= ShiftBy(0) and Input(1);
Shifted0Bits(2) <= ShiftBy(0) and Input(2);
Shifted0Bits(3) <= ShiftBy(0) and Input(3);
Shifted0Bits(4) <= ShiftBy(0) and Input(4);
Shifted0Bits(5) <= ShiftBy(0) and Input(5);
Shifted0Bits(6) <= ShiftBy(0) and Input(6);
Shifted0Bits(7) <= ShiftBy(0) and Input(7);


Shifted1Bits(0) <= '0';
Shifted1Bits(1) <= ShiftBy(1) and Input(0);
Shifted1Bits(2) <= ShiftBy(1) and Input(1);
Shifted1Bits(3) <= ShiftBy(1) and Input(2);
Shifted1Bits(4) <= ShiftBy(1) and Input(3);
Shifted1Bits(5) <= ShiftBy(1) and Input(4);
Shifted1Bits(6) <= ShiftBy(1) and Input(5);
Shifted1Bits(7) <= ShiftBy(1) and Input(6);


Shifted2Bits(0) <= '0';
Shifted2Bits(1) <= '0';
Shifted2Bits(2) <= ShiftBy(2) and Input(0);
Shifted2Bits(3) <= ShiftBy(2) and Input(1);
Shifted2Bits(4) <= ShiftBy(2) and Input(2);
Shifted2Bits(5) <= ShiftBy(2) and Input(3);
Shifted2Bits(6) <= ShiftBy(2) and Input(4);
Shifted2Bits(7) <= ShiftBy(2) and Input(5);


Shifted3Bits(0) <= '0';
Shifted3Bits(1) <= '0';
Shifted3Bits(2) <= '0';
Shifted3Bits(3) <= ShiftBy(3) and Input(0);
Shifted3Bits(4) <= ShiftBy(3) and Input(1);
Shifted3Bits(5) <= ShiftBy(3) and Input(2);
Shifted3Bits(6) <= ShiftBy(3) and Input(3);
Shifted3Bits(7) <= ShiftBy(3) and Input(4);


Shifted4Bits(0) <= '0';
Shifted4Bits(1) <= '0';
Shifted4Bits(2) <= '0';
Shifted4Bits(3) <= '0';
Shifted4Bits(4) <= ShiftBy(4) and Input(0);
Shifted4Bits(5) <= ShiftBy(4) and Input(1);
Shifted4Bits(6) <= ShiftBy(4) and Input(2);
Shifted4Bits(7) <= ShiftBy(4) and Input(3);


Shifted5Bits(0) <= '0';
Shifted5Bits(1) <= '0';
Shifted5Bits(2) <= '0';
Shifted5Bits(3) <= '0';
Shifted5Bits(4) <= '0';
Shifted5Bits(5) <= ShiftBy(5) and Input(0);
Shifted5Bits(6) <= ShiftBy(5) and Input(1);
Shifted5Bits(7) <= ShiftBy(5) and Input(2);


Shifted6Bits(0) <= '0';
Shifted6Bits(1) <= '0';
Shifted6Bits(2) <= '0';
Shifted6Bits(3) <= '0';
Shifted6Bits(4) <= '0';
Shifted6Bits(5) <= '0';
Shifted6Bits(6) <= ShiftBy(6) and Input(0);
Shifted6Bits(7) <= ShiftBy(6) and Input(1);


Shifted7Bits(0) <= '0';
Shifted7Bits(1) <= '0';
Shifted7Bits(2) <= '0';
Shifted7Bits(3) <= '0';
Shifted7Bits(4) <= '0';
Shifted7Bits(5) <= '0';
Shifted7Bits(6) <= '0';
Shifted7Bits(7) <= ShiftBy(7) and Input(0);

OutputSum <= Shifted0Bits or Shifted1Bits or Shifted2Bits or Shifted3Bits or Shifted4Bits or Shifted5Bits or Shifted6Bits or Shifted7Bits;
UseSum <= (not Count(7)) and (not Count(6)) and (not Count(5)) and (not Count(4)) and (not Count(3));
FinalOutput_8_and_1: AndEightBitByOneBit port map(eight_bits => OutputSum, one_bit => UseSum, output => Output);
end dataflow;