----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 05:36:14 PM
-- Design Name: 
-- Module Name: ByteRegister - Dataflow
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

entity ByteRegister is Port(
    data_in: in std_logic_vector(7 downto 0);
    overwrite: in std_logic;
    rising_edge_clk: in std_logic;
    data_out: out std_logic_vector(7 downto 0)
);
end ByteRegister;

architecture Structural of ByteRegister is

component OneBitDFlipFlop is Port(
    bit_in: in std_logic;
    rising_edge_clk: in std_logic;
    bit_out: out std_logic
);
end component;

signal overwrite_clk: std_logic;

begin
    overwrite_clk <= overwrite and rising_edge_clk;
    bit_7: OneBitDFlipFlop port map(data_in(7), overwrite_clk, data_out(7));
    bit_6: OneBitDFlipFlop port map(data_in(6), overwrite_clk, data_out(6));
    bit_5: OneBitDFlipFlop port map(data_in(5), overwrite_clk, data_out(5));
    bit_4: OneBitDFlipFlop port map(data_in(4), overwrite_clk, data_out(4));
    bit_3: OneBitDFlipFlop port map(data_in(3), overwrite_clk, data_out(3));
    bit_2: OneBitDFlipFlop port map(data_in(2), overwrite_clk, data_out(2));
    bit_1: OneBitDFlipFlop port map(data_in(1), overwrite_clk, data_out(1));
    bit_0: OneBitDFlipFlop port map(data_in(0), overwrite_clk, data_out(0));

end Structural;
