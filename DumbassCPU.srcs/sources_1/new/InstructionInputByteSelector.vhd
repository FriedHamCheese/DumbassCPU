----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 01:00:50 AM
-- Design Name: 
-- Module Name: InstructionInputByteSelector - Structural
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

entity InstructionInputByteSelector is Port(
    input_byte: in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector (3 downto 0);
    instruction_0_out,
    instruction_1_out,
    instruction_2_out,
    instruction_3_out,
    instruction_4_out,
    instruction_5_out,
    instruction_6_out,
    instruction_7_out,
    instruction_8_out,
    instruction_9_out,
    instruction_10_out,
    instruction_11_out,
    instruction_12_out,
    instruction_13_out,
    instruction_14_out,
    instruction_15_out
    : out std_logic_vector (7 downto 0)
);
end InstructionInputByteSelector;

architecture Structural of InstructionInputByteSelector is

component InstructionInputBitSelector is Port(
    input_bit: in std_logic;
    selecting_bits: in std_logic_vector (3 downto 0);
    output_bits: out std_logic_vector (15 downto 0)
);
end component;

type InstructionOut is array(15 downto 0) of std_logic_vector(7 downto 0);
signal instruction_out: InstructionOut;

type ByBitOrder is array(7 downto 0) of std_logic_vector(15 downto 0);
signal by_bit_order: ByBitOrder;

begin
    bit_7: InstructionInputBitSelector port map(input_byte(7), selecting_bits, by_bit_order(7));
    bit_6: InstructionInputBitSelector port map(input_byte(6), selecting_bits, by_bit_order(6));
    bit_5: InstructionInputBitSelector port map(input_byte(5), selecting_bits, by_bit_order(5));
    bit_4: InstructionInputBitSelector port map(input_byte(4), selecting_bits, by_bit_order(4));
    bit_3: InstructionInputBitSelector port map(input_byte(3), selecting_bits, by_bit_order(3));
    bit_2: InstructionInputBitSelector port map(input_byte(2), selecting_bits, by_bit_order(2));
    bit_1: InstructionInputBitSelector port map(input_byte(1), selecting_bits, by_bit_order(1));
    bit_0: InstructionInputBitSelector port map(input_byte(0), selecting_bits, by_bit_order(0));

    bit_order_to_instruction_order: process(by_bit_order) is
    begin
        for instruction in 0 to 15 loop
            for gbit in 0 to 7 loop
                instruction_out(instruction)(gbit) <= by_bit_order(gbit)(instruction);
            end loop;
        end loop;
     end process bit_order_to_instruction_order;
    
    instruction_15_out <= instruction_out(15);
    instruction_14_out <= instruction_out(14);
    instruction_13_out <= instruction_out(13);
    instruction_12_out <= instruction_out(12);
    instruction_11_out <= instruction_out(11);
    instruction_10_out <= instruction_out(10);
    instruction_9_out <= instruction_out(9);
    instruction_8_out <= instruction_out(8);
    instruction_7_out <= instruction_out(7);
    instruction_6_out <= instruction_out(6);
    instruction_5_out <= instruction_out(5);
    instruction_4_out <= instruction_out(4);
    instruction_3_out <= instruction_out(3);
    instruction_2_out <= instruction_out(2);
    instruction_1_out <= instruction_out(1);
    instruction_0_out <= instruction_out(0);

end Structural;
