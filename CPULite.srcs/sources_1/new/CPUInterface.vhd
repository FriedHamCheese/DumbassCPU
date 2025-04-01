library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterface is Port(
    clk, 
	seven_seg_clk
	: in std_logic;
    input_opcode: in std_logic_vector(7 downto 0);
    input_immediate: in std_logic_vector(7 downto 0);
	seven_seg_led : out STD_LOGIC_VECTOR(6 downto 0);
	seven_seg_on : out STD_LOGIC_VECTOR(3 downto 0);
	program_counter_out : out std_logic_vector(7 downto 0);
	a_equal_b,
	a_greater_b, 
	a_lesser_b
	: out std_logic
	
);
end CPUInterface;

architecture Structural of CPUInterface is

component CPU is Port(
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
	cpu_m: CPU port map(
		clk => clk, 
		opcode => input_opcode, 
		immediate => input_immediate, 
		register_A_port_out => register_a_out,
		register_B_port_out => register_b_out,
		program_counter_out => program_counter_out,
		a_equal_b => a_equal_b,
		a_greater_b => a_greater_b,
		a_lesser_b => a_lesser_b
	);
	
	seven_seg: SevenSeg port map(
		clk => seven_seg_clk,
		a => register_b_out,
		b => register_a_out,
		seven_seg_led => seven_seg_led,
		seven_seg_on => seven_seg_on
	);
end Structural;