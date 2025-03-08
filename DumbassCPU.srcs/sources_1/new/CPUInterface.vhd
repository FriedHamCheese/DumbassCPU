library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output_reg_b,
    debug_output
    : out std_logic_vector(7 downto 0)
);
end CPUInterface;

architecture Structural of CPUInterface is

component Core_ByteMultiplexer is Port(
    byte_0_in, byte_1_in, byte_2_in, byte_3_in, byte_4_in, byte_5_in, byte_6_in, byte_7_in, 
	byte_8_in, byte_9_in, byte_10_in, byte_11_in, byte_12_in, byte_13_in, byte_14_in, byte_15_in, 
	byte_16_in, byte_17_in, byte_18_in, byte_19_in, byte_20_in, byte_21_in, byte_22_in, byte_23_in,
    byte_24_in, byte_25_in, byte_26_in, byte_27_in, byte_28_in, byte_29_in, byte_30_in, byte_31_in,
    byte_32_in, byte_33_in, byte_34_in, byte_35_in, byte_36_in, byte_37_in, byte_38_in, byte_39_in,
    byte_40_in, byte_41_in, byte_42_in, byte_43_in, byte_44_in, byte_45_in, byte_46_in, byte_47_in,
	byte_48_in, byte_49_in, byte_50_in, byte_51_in, byte_52_in, byte_53_in, byte_54_in, byte_55_in,
    byte_56_in, byte_57_in, byte_58_in, byte_59_in, byte_60_in, byte_61_in, byte_62_in, byte_63_in    
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

component Subtracter is 
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        Difference : out  STD_LOGIC_VECTOR (7 downto 0);
        Borrow : out  STD_LOGIC
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
    a_opxor_b,
    internal_debug_output,
    subtracter_out
: std_logic_vector(7 downto 0) := "00000000";
    
signal 
    register_a_overwrite,
    register_b_overwrite,
    placeholder_bit
: std_logic := '0';

-- opcodes:
-- 0    set A, imm
-- 1    set A, B
-- 2    set B, A
-- 3    set A, mem[B]
-- 4    set mem[B], A

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
    internal_debug_output(0) <= register_a_overwrite;
    debug_output <= register_a_in;

    register_a_overwrite <= 
			((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and (not opcode(1)) and (not opcode(0)))	-- 0
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and (not opcode(1)) and (opcode(0)))		-- 1
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and (opcode(1)) and (opcode(0)))			-- 3
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (opcode(2)) and (not opcode(1)) and (opcode(0)))			-- 5
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (opcode(2)) and (opcode(1)) and (not opcode(0)))			-- 6

		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (opcode(3)) and (not opcode(2)) and (not opcode(1)) and (not opcode(0)))		-- 8
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (opcode(3)) and (not opcode(2)) and (not opcode(1)) and (opcode(0)))			-- 9
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (opcode(3)) and (not opcode(2)) and (opcode(1)) and (not opcode(0)))			-- 10
		or 	((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (opcode(3)) and (not opcode(2)) and (opcode(1)) and (opcode(0)))				-- 11
	;
	
    register_a: ByteRegister port map(register_a_in, register_a_overwrite, clk, register_a_out);

    register_b_overwrite <= 
			((not opcode(7)) and (not opcode(6)) and (not opcode(5)) and (not opcode(4)) and (not opcode(3)) and (not opcode(2)) and (opcode(1)) and (not opcode(0)))		-- 2
	;
    register_b: ByteRegister port map(register_b_in, register_b_overwrite, clk, register_b_out);

    to_register_a_input: Core_ByteMultiplexer port map(
        immediate, register_b_out, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, subtracter_out, placeholder_byte,
        a_opand_b, a_opor_b, not_a, a_opxor_b, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        opcode,
        register_a_in
    );
    
    to_register_b_input: Core_ByteMultiplexer port map(
        placeholder_byte, placeholder_byte, register_a_out, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        
        opcode,
        register_b_in
    );
    
    not_a <= not register_a_out;
    a_opand_b <= register_a_out and register_b_out;
    a_opor_b <= register_a_out or register_b_out;
    a_opxor_b <= register_a_out xor register_b_out;
    
    sub: Subtracter port map(A => register_a_out, B => register_b_out, Difference => subtracter_out, Borrow => placeholder_bit);

end Structural;
