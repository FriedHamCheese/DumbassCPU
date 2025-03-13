library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output,
    debug_output_reg_b
    : out std_logic_vector(7 downto 0)
);
end CPUInterface;

architecture Structural of CPUInterface is

component Adder8Bit is
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        Cin : in  STD_LOGIC;
        Sum : out  STD_LOGIC_VECTOR (7 downto 0);
        Cout : out  STD_LOGIC
    );
end component;

component ProgramRom is Port(
    address : in std_logic_vector(7 downto 0);
    opcode : out std_logic_vector(7 downto 0);
    immediate : out std_logic_vector(7 downto 0)
);
end component;

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

component AndEightBitByOneBit is Port(
    eight_bits: in std_logic_vector(7 downto 0);
    one_bit: in std_logic;
    output: out std_logic_vector(7 downto 0)
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
	
    program_counter_in,
    program_counter_current_index,
    program_counter_incremented_index,
    program_counter_opcode,
	program_counter_immediate,
    program_counter_index_from_reg_a,
    program_counter_incremented_index_and,
	
    final_opcode,
    final_immediate,
    final_immediate_use_entered_immediate,
    final_immediate_use_pc_immediate,
    final_opcode_use_pc,
	final_opcode_use_entered_opcode
	
    : std_logic_vector(7 downto 0) := "00000000";

signal 
    register_a_overwrite,
    register_b_overwrite,
	
	increment_program_counter,
    program_counter_overwrite,
	
    use_entered_opcode,
	is_jump_instruction,
	placeholder_bit
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

-- 129  jmp A

begin
    debug_output <= program_counter_incremented_index_and;
    debug_output_reg_a <= register_a_out;
    debug_output_reg_b <= register_b_out;
	
    use_entered_opcode <= not opcode(7);
	
	-- deciding whether to use user entered opcode and immediate or the ones from ROM
    final_opcode_use_pc_opcode_8_and_1: AndEightBitByOneBit port map(
		eight_bits => program_counter_opcode, 
		one_bit => opcode(7), 
		output => final_opcode_use_pc
	);
    final_opcode_use_entered_opcode_8_and_1: AndEightBitByOneBit port map(
		eight_bits => opcode, 
		one_bit => use_entered_opcode, 
		output => final_opcode_use_entered_opcode
	);

    final_immediate_use_entered_immediate_8_and_1: AndEightBitByOneBit port map(
        eight_bits => immediate, 
        one_bit => use_entered_opcode, 
        output => final_immediate_use_entered_immediate
    );     
    final_immediate_use_pc_immediate_8_and_1: AndEightBitByOneBit port map(
        eight_bits => program_counter_immediate, 
        one_bit => opcode(7), 
        output => final_immediate_use_pc_immediate
    );
    final_opcode <= final_opcode_use_pc or final_opcode_use_entered_opcode;
    final_immediate <= final_immediate_use_pc_immediate or final_immediate_use_entered_immediate;

	--

    register_a_overwrite <= (not ((not final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (not final_opcode(0))))
                        and (not ((not final_opcode(3)) and (final_opcode(2)) and (not final_opcode(1)) and (not final_opcode(0))))
                        and (not ((final_opcode(3)) and (final_opcode(2))));
    register_a: ByteRegister port map(register_a_in, register_a_overwrite, clk, register_a_out);

    register_b_overwrite <= (not (final_opcode(3)) and (not final_opcode(2)) and final_opcode(1) and (not final_opcode(0)));
    register_b: ByteRegister port map(register_b_in, register_b_overwrite, clk, register_b_out);

    to_register_a_input: Core_ByteMultiplexer port map(
        final_immediate,
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
        
        final_opcode,
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
        
        final_opcode,
        register_b_in
    );
    
    not_a <= not register_a_out;
    a_opand_b <= register_a_out and register_b_out;
    a_opor_b <= register_a_out or register_b_out;
    a_opxor_b <= register_a_out xor register_b_out;
    
	-- program counter and ROM sectioon
    program_counter: ByteRegister port map(data_in => program_counter_in, 
                        overwrite => '1',
                        rising_edge_clk => clk,
                        data_out => program_counter_current_index              
    );

	is_jump_instruction <= 
	       ((final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (final_opcode(0)))
    ; 
    increment_program_counter <= opcode(7) and not is_jump_instruction;

	program_counter_increment: Adder8Bit port map(
	   A => program_counter_current_index, 
	   B => "00000000", 
	   Cin => '1', 
	   Sum => program_counter_incremented_index, 
	   Cout => placeholder_bit
    );
	program_counter_use_incremented_index_and: AndEightBitByOneBit port map(
	   eight_bits => program_counter_incremented_index, 
	   one_bit => increment_program_counter, 
	   output => program_counter_incremented_index_and
	);
	
    use_register_a_as_pc_index_and: AndEightBitByOneBit port map(
        eight_bits => register_a_out,
        one_bit => is_jump_instruction,
        output => program_counter_index_from_reg_a
    );
	
    program_counter_in <= program_counter_index_from_reg_a or program_counter_incremented_index_and;
    program_rom: ProgramRom port map(
		address => program_counter_current_index, 
		opcode => program_counter_opcode, 
		immediate => program_counter_immediate
	);

end Structural;
