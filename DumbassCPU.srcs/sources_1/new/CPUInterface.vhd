----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 05:33:11 PM
-- Design Name: 
-- Module Name: CPUInterface - Structural
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

entity CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output_reg_b
    : out std_logic_vector(7 downto 0)
    
);
end CPUInterface;

architecture Structural of CPUInterface is

component InstructionInputByteSelector is Port(
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
end component;

component InstructionByteOutputSelector is Port(
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
    selecting_bits: in std_logic_vector(3 downto 0);
    selected_byte: out std_logic_vector(7 downto 0)
);
end component;

component ByteRegister is Port(
    data_in: in std_logic_vector(7 downto 0);
    overwrite: in std_logic;
    rising_edge_clk: in std_logic;
    data_out: out std_logic_vector(7 downto 0)
);
end component;

signal 
    placeholder_byte, 
    register_a_in, 
    register_a_out,
    register_b_in,
    register_b_out
    : std_logic_vector(7 downto 0);
    
signal 
    register_a_overwrite,
    register_b_overwrite
    : std_logic := '0';

-- opcodes:
-- 0    set A, imm
-- 1    set A, B
-- 2    set B, A
-- 3    set A, mem[imm]
-- 4    set mem[imm], A

-- 5    add (A = A+B)
-- 6    sub (A = A-B)
-- 7    shl B (A = A << B)

begin
    placeholder_byte <= "00000000";
    debug_output_reg_a <= register_a_out;
    debug_output_reg_b <= register_b_out;

    register_a_overwrite <= ((not opcode(3)) and (not opcode(2)) and (not opcode(1)) and (not opcode(0)))
                        or  ((not opcode(3)) and (not opcode(2)) and (not opcode(1)) and (opcode(0)))
    ;
    register_a: ByteRegister port map(register_a_in, register_a_overwrite, clk, register_a_out);

    register_b_overwrite <= (not (opcode(3)) and (not opcode(2)) and opcode(1) and (not opcode(0)));
    register_b: ByteRegister port map(register_b_in, register_b_overwrite, clk, register_b_out);

    to_register_a_input: InstructionByteOutputSelector port map(
        immediate,
        register_b_out,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,

        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        
        opcode(3 downto 0),
        register_a_in
    );
    
    to_register_b_input: InstructionByteOutputSelector port map(
        placeholder_byte,
        placeholder_byte,
        register_a_out,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,

        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        
        opcode(3 downto 0),
        register_b_in
    );

end Structural;
