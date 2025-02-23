library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

    to_register_a_input: Core_ByteMultiplexer port map(
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
    
    to_register_b_input: Core_ByteMultiplexer port map(
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
