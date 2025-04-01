library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_TestBench is
--  Port ( );
end CPU_TestBench;

architecture Behavioral of CPU_TestBench is

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

signal 
    opcode, 
    immediate, 
    register_A_out, 
    register_B_out, 
    program_counter: std_logic_vector(7 downto 0);
    
signal 
    clk,
    a_equal_b,
    a_greater_b,
    a_lesser_b
: std_logic;

begin
    cpu_m: CPU port map(
        clk => clk, 
        opcode => opcode, 
        immediate => immediate, 
        register_A_port_out => register_A_out, 
        register_B_port_out => register_B_out, 
        program_counter_out => program_counter,
        a_equal_b => a_equal_b,
        a_greater_b => a_greater_b,
        a_lesser_b => a_lesser_b
    );

    proc: process is
    begin
        -- set A, imm
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 110ns;             
        assert(register_A_out = "10101010");
        
        -- set B, imm
        opcode <= "00000101";
        immediate <= "11010011";  
        wait for 110ns;             
        assert(register_B_out = "11010011");
        
        -- set B, A        
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000010";
        wait for 100ns;
        assert(register_B_out = "10101010");
  
        -- set A, B
        opcode <= "00000000";
        immediate <= "00000000";       
        wait for 100ns;
        opcode <= "00000001";
        wait for 100ns;
        assert(register_A_out = "10101010");            
        
        -- set mem[A], B
        opcode <= "00000000";
        immediate <= "00001000";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "01000101";
        wait for 100ns;
        opcode <= "00000100";
        wait for 100ns;
        -- + set A, mem[A]
        opcode <= "00000000";
        immediate <= "00001000";
        wait for 100ns;
        opcode <= "00000011";
        wait for 100ns;
        assert(register_A_out = "01000101");
    
        -- sub (11111111 - 10101010 = 01010101)
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "11111111";
        wait for 100ns;
        opcode <= "00000110";
        wait for 100ns;
        assert(register_A_out = "01010101");
        
        -- add (10101010 + 11010101 = 01111111)
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "11010101";
        wait for 100ns;
        opcode <= "00000111";        
        wait for 100ns;
        assert(register_A_out = "01111111");        
        
        -- and (11111111 & 10101010 = 10101010)
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "11111111";
        wait for 100ns;
        opcode <= "00001000";
        wait for 100ns;
        assert(register_A_out = "10101010");        
        
        -- or (10101010 || 01010101 = 11111111)
        opcode <= "00000101";
        immediate <= "01010101";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00001001";
        wait for 100ns;
        assert(register_A_out = "11111111");
        
        -- not (11011011 = 00100100)
        opcode <= "00000000";
        immediate <= "11011011";
        wait for 100ns;
        opcode <= "00001010";
        wait for 100ns;
        assert(register_A_out = "00100100");   
        
        -- xor (10101010 || 10101010 = 00000000)
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00001011";
        wait for 100ns;
        assert(register_A_out = "00000000");  
        
        -- prop B, 0
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00001100";
        wait for 100ns;
        assert(register_B_out = "00000000");
        
        opcode <= "00000101";
        immediate <= "00010101";
        wait for 100ns;
        opcode <= "00001100";
        wait for 100ns;
        assert(register_B_out = "11111111");               
        
        
        -- shl B (11010010 << 3 = 10010000)
        opcode <= "00000000";
        immediate <= "11010010";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "00000011";
        wait for 100ns;
        opcode <= "00010000";
        wait for 100ns;
        assert (register_A_out = "10010000");
        
        -- shr B (10100101 << 5 = 00000101)
        opcode <= "00000000";
        immediate <= "10100101";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "00000101";
        wait for 100ns;
        opcode <= "00010001";
        wait for 100ns;
        assert (register_A_out = "00000101");   
        
        -- mul A, B (01100110 x 00101011 = 00100010)
        opcode <= "00000000";
        immediate <= "01100110";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "00101011";
        wait for 100ns;
        opcode <= "00010010";
        wait for 100ns;
        assert (register_A_out = "00100010");    
        
        -- rdiv A, B (01110101 ~/ 7 = 00011101)
        opcode <= "00000000";
        immediate <= "01110101";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "00000111";
        wait for 100ns;
        opcode <= "00010011";
        wait for 100ns;
        assert (register_A_out = "00011101");           
        
        -- set pc, A
		opcode <= "00000000";
		immediate <= "00100100";
		wait for 100ns;
		opcode <= "00111111";
		wait for 100ns;
		assert(program_counter = "00100100");
		
		
        -- test comparator results
        -- a == b
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        assert (a_equal_b = '1' and a_greater_b = '0' and a_lesser_b = '0');
        
        -- a > b
        opcode <= "00000000";
        immediate <= "01000001";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "01000000";
        wait for 100ns;
        assert (a_equal_b = '0' and a_greater_b = '1' and a_lesser_b = '0');
        
        -- a < b
        opcode <= "00000000";
        immediate <= "00010101";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "01000000";
        wait for 100ns;
        assert (a_equal_b = '0' and a_greater_b = '0' and a_lesser_b = '1');
    wait;
    end process proc;
end Behavioral;
