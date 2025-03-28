library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    register_A_port_out,
    register_B_port_out,
    program_counter_out
    : out std_logic_vector(7 downto 0);
    
    a_equal_b,
    a_greater_b,
    a_lesser_b
    : out std_logic
);
end CPU;

architecture Structural of CPU is

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

component ShiftLeft is
    Port ( Input : in std_logic_vector(7 downto 0);
           Count : in std_logic_vector(7 downto 0);
           Output : out std_logic_vector(7 downto 0));
end component;

component AndEightBitByOneBit is Port(
    eight_bits: in std_logic_vector(7 downto 0);
    one_bit: in std_logic;
    output: out std_logic_vector(7 downto 0)
);
end component;

component memory16x8 is
    Port (
        clk  : in  STD_LOGIC;
        we   : in  STD_LOGIC;  -- Write Enable
        addr : in  STD_LOGIC_VECTOR(3 downto 0);
        din  : in  STD_LOGIC_VECTOR(7 downto 0);
        dout : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component ByteComparator is Port(
	a, b: in std_logic_vector (7 downto 0);
	equal, greater, lesser
	: out std_logic
);
end component;

component ShiftRight is
    Port ( Input : in std_logic_vector(7 downto 0);
           Count : in std_logic_vector(7 downto 0);
           Output : out std_logic_vector(7 downto 0));
end component;

component RoughDivide is
    Port ( Dividend : in std_logic_vector(7 downto 0);
           Divisor : in std_logic_vector(7 downto 0);
           Quotient : out std_logic_vector(7 downto 0));
end component;

component Multiplier8Bit is
    Port (
        a : in  STD_LOGIC_VECTOR (7 downto 0);
        b : in  STD_LOGIC_VECTOR (7 downto 0);
        c : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

signal 
    placeholder_byte,
    register_a_in, 
    register_a_out,
    register_b_in,
    register_b_out,
	
	ram_output,
	
    a_opand_b,
    not_a,
    a_opor_b,
    a_opxor_b,
	prop_0_b,

    internal_program_counter_out,
    subtracter_out,
    adder_out,
    shift_left_out,
    shift_right_result,
    rough_divide_out,
    multiplier_out,
  
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
  
    write_to_ram,
  
	increment_program_counter,
    program_counter_overwrite,
	
    use_entered_opcode,
    set_pc_as_reg_a,
  
    placeholder_bit
: std_logic := '0';

-- opcodes:
-- 0    set A, imm
-- 1    set A, B
-- 2    set B, A
-- 3    set A, mem[A]
-- 4    set mem[A], B
-- 5    set B, imm

-- 6    sub A, B
-- 7    add A, B

-- 8    and A, B
-- 9    or B
-- 10   not A
-- 11   xor A, B
-- 12 	prop B, 0

-- 16   shl A, B
-- 17   shr A, B
-- 18   mul A, B
-- 19   rdiv A, B

-- 62	nop
-- 63   set pc, A

-- 129  jmp A

begin
    program_counter_out <= program_counter_current_index;
    register_A_port_out <= register_a_out;
    register_B_port_out <= register_b_out;

    internal_program_counter_out(0) <= register_a_overwrite;
	
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
    
    register_a_overwrite <= 
			((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (not final_opcode(0)))	-- 0
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (final_opcode(0)))		-- 1
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (final_opcode(0)))			-- 3
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (final_opcode(2)) and (final_opcode(1)) and (not final_opcode(0)))			-- 6
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (final_opcode(2)) and (final_opcode(1)) and (final_opcode(0)))			    -- 7
		
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (not final_opcode(0)))		-- 8
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (final_opcode(0)))			-- 9
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (not final_opcode(0)))			-- 10
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (final_opcode(0)))				-- 11

		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (not final_opcode(0)))		-- 16
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (final_opcode(0)))		    -- 17
        or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (not final_opcode(0)))		    -- 18
        or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (final_opcode(0)))		        -- 19
	;
    register_a: ByteRegister port map(data_in=>register_a_in, overwrite=>register_a_overwrite, rising_edge_clk=>clk, data_out=>register_a_out);

    register_b_overwrite <= 
			((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (final_opcode(1)) and (not final_opcode(0)))		-- 2
        or  ((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (final_opcode(2)) and (not final_opcode(1)) and (final_opcode(0)))		    -- 5 
		or 	((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (final_opcode(3)) and (final_opcode(2)) and (not final_opcode(1)) and (not final_opcode(0)))		    -- 12
	;
    register_b: ByteRegister port map(data_in=>register_b_in, overwrite=>register_b_overwrite, rising_edge_clk=>clk, data_out=>register_b_out);

    to_register_a_input: Core_ByteMultiplexer port map(
        final_immediate, register_b_out, placeholder_byte, ram_output, placeholder_byte, placeholder_byte, subtracter_out, adder_out,
        a_opand_b, a_opor_b, not_a, a_opxor_b, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        shift_left_out, shift_right_result, multiplier_out, rough_divide_out, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        final_opcode, 
        register_a_in
      );    
    
    to_register_b_input: Core_ByteMultiplexer port map(
        placeholder_byte, placeholder_byte, register_a_out, placeholder_byte, placeholder_byte, final_immediate, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, prop_0_b, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,
        placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte, placeholder_byte,       
        final_opcode, 
        register_b_in
    );
    
    not_a <= not register_a_out;
    a_opand_b <= register_a_out and register_b_out;
    a_opor_b <= register_a_out or register_b_out;
    a_opxor_b <= register_a_out xor register_b_out;
	
	prop_0_b(7) <= register_b_out(0);
	prop_0_b(6) <= register_b_out(0);
	prop_0_b(5) <= register_b_out(0);
	prop_0_b(4) <= register_b_out(0);
	prop_0_b(3) <= register_b_out(0);
	prop_0_b(2) <= register_b_out(0);
	prop_0_b(1) <= register_b_out(0);
	prop_0_b(0) <= register_b_out(0);

    adder: Adder8Bit port map(A => register_a_out, B => register_b_out, cin => '0', sum => adder_out, cout => placeholder_bit);
    sub: Subtracter port map(A => register_a_out, B => register_b_out, Difference => subtracter_out, Borrow => placeholder_bit);
    left_shift: ShiftLeft port map(Input => register_a_out, Count => register_b_out, Output => shift_left_out);
    right_shift: ShiftRight port map(Input => register_a_out, Count => register_b_out, Output => shift_right_result);
    rough_divide: RoughDivide port map(Dividend => register_a_out, Divisor => register_b_out, Quotient => rough_divide_out);
    
    write_to_ram <= ((not final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (final_opcode(2)) and (not final_opcode(1)) and (not final_opcode(0)));
    ram: memory16x8 port map(clk => clk, we => write_to_ram, addr => register_a_out(3 downto 0), din => register_b_out, dout => ram_output);

    comparator: ByteComparator port map(
        a => register_a_out, b => register_b_out, 
        equal => a_equal_b, 
        greater => a_greater_b, 
        lesser => a_lesser_b
    );
    
    multiplier: Multiplier8Bit port map(
        a => register_a_out,
        b => register_b_out,
        c => multiplier_out
    );

	-- program counter and ROM sectioon
    program_counter: ByteRegister port map(data_in => program_counter_in, 
                        overwrite => program_counter_overwrite,
                        rising_edge_clk => clk,
                        data_out => program_counter_current_index              
    );

	set_pc_as_reg_a <= 
	       ((not final_opcode(7)) and (not final_opcode(6)) and (final_opcode(5)) and (final_opcode(4)) and (final_opcode(3)) and (final_opcode(2)) and (final_opcode(1)) and (final_opcode(0)))                       -- set pc, A
	       or ((final_opcode(7)) and (not final_opcode(6)) and (not final_opcode(5)) and (not final_opcode(4)) and (not final_opcode(3)) and (not final_opcode(2)) and (not final_opcode(1)) and (final_opcode(0)))   -- jmp, A
    ; 
    increment_program_counter <= opcode(7) and not set_pc_as_reg_a;
    program_counter_overwrite <= set_pc_as_reg_a or increment_program_counter;

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
        one_bit => set_pc_as_reg_a,
        output => program_counter_index_from_reg_a
    );
	
    program_counter_in <= program_counter_index_from_reg_a or program_counter_incremented_index_and;
    program_rom: ProgramRom port map(
		address => program_counter_current_index, 
		opcode => program_counter_opcode, 
		immediate => program_counter_immediate
	);

end Structural;
