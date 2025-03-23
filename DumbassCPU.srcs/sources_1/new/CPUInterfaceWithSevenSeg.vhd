library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterfaceWithSevenSeg is Port(
    clk, 
	seven_seg_clk
	: in std_logic;
    input_opcode: in std_logic_vector(7 downto 0);
    input_immediate: in std_logic_vector(7 downto 0);
	seven_seg_led : out STD_LOGIC_VECTOR(6 downto 0);
	seven_seg_on : out STD_LOGIC_VECTOR(3 downto 0);
	a_equal_b,
	a_greater_b, 
	a_lesser_b
	: out std_logic
	
);
end CPUInterfaceWithSevenSeg;

architecture Structural of CPUInterfaceWithSevenSeg is

component CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output,
    debug_output_reg_b
    : out std_logic_vector(7 downto 0);
    
    a_equal_b,
    a_greater_b,
    a_lesser_b
    : out std_logic
);
end component;

component SevenSeg is
    Port (
        clk : in STD_LOGIC;
        a : in STD_LOGIC_VECTOR(7 downto 0);
        b : in STD_LOGIC_VECTOR(7 downto 0);
        seven_seg_led : out STD_LOGIC_VECTOR(6 downto 0);
        seven_seg_on : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal 
	register_a_out, 
	register_b_out,
	placeholder_byte
: std_logic_vector(7 downto 0) := "00000000";

begin
	cpu: CPUInterface port map(
		clk => clk, 
		opcode => input_opcode, 
		immediate => input_immediate, 
		debug_output_reg_a => register_a_out,
		debug_output_reg_b => register_b_out,
		debug_output => placeholder_byte,
		a_equal_b => a_equal_b,
		a_greater_b => a_greater_b,
		a_lesser_b => a_lesser_b
	);
	
	seven_seg: SevenSeg port map(
		clk => seven_seg_clk,
		a => register_a_out,
		b => register_b_out,
		seven_seg_led => seven_seg_led,
		seven_seg_on => seven_seg_on
	);
end Structural;