library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output_reg_b
    --debug_output
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
    instruction_15_in,
    instruction_16_in,
    instruction_17_in,
    instruction_18_in,
    instruction_19_in,
    
    instruction_20_in,
    instruction_21_in,
    instruction_22_in,
    instruction_23_in,
    instruction_24_in,
    instruction_25_in,
    instruction_26_in,
    instruction_27_in,
    instruction_28_in,
    instruction_29_in,
    
    instruction_30_in,
    instruction_31_in,
    instruction_32_in,
    instruction_33_in,
    instruction_34_in,
    instruction_35_in,
    instruction_36_in,
    instruction_37_in,
    instruction_38_in,
    instruction_39_in,
    
    instruction_40_in,
    instruction_41_in,
    instruction_42_in,
    instruction_43_in,
    instruction_44_in,
    instruction_45_in,
    instruction_46_in,
    instruction_47_in,
    instruction_48_in,
    instruction_49_in,
    
    instruction_50_in,
    instruction_51_in,
    instruction_52_in,
    instruction_53_in,
    instruction_54_in,
    instruction_55_in,
    instruction_56_in,
    instruction_57_in,
    instruction_58_in,
    instruction_59_in,

    instruction_60_in,
    instruction_61_in,
    instruction_62_in,
    instruction_63_in    
    : in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(7 downto 0);
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
    register_b_out,
    a_opand_b,
    not_a,
    a_opor_b,
    a_opxor_b
    : std_logic_vector(7 downto 0) := "00000000";
    
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

-- 8    and B (A = A and B)
-- 9    or B (A = A or B)
-- 10   not  (not A)
-- 11   xor B (A = A xor B)

begin
    debug_output_reg_a <= register_a_out;
    debug_output_reg_b <= register_b_out;
    --debug_output <= not register_a_out;

    register_a_overwrite <= (not ((not opcode(3)) and (not opcode(2)) and (opcode(1)) and (not opcode(0))))
                        and (not ((not opcode(3)) and (opcode(2)) and (not opcode(1)) and (not opcode(0))))
                        and (not ((opcode(3)) and (opcode(2))));
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

        a_opand_b,
        a_opor_b,
        not_a,
        a_opxor_b,
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
        
        opcode,
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
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        placeholder_byte,
        
        opcode,
        register_b_in
    );
    
    not_a <= not register_a_out;
    a_opand_b <= register_a_out and register_b_out;
    a_opor_b <= register_a_out or register_b_out;
    a_opxor_b <= register_a_out xor register_b_out;

end Structural;
