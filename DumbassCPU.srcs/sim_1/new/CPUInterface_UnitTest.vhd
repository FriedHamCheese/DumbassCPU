library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterface_UnitTest is
--  Port ( );
end CPUInterface_UnitTest;

architecture Behavioral of CPUInterface_UnitTest is

component CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output_reg_b,
    debug_output
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
    debug_output_reg_a, 
    debug_output_reg_b, 
    debug_output: std_logic_vector(7 downto 0);
    
signal 
    clk,
    a_equal_b,
    a_greater_b,
    a_lesser_b
: std_logic;

begin
    cpu: CPUInterface port map(
        clk => clk, 
        opcode => opcode, 
        immediate => immediate, 
        debug_output_reg_a => debug_output_reg_a, 
        debug_output_reg_b => debug_output_reg_b, 
        debug_output => debug_output,
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
        assert(debug_output_reg_a = "10101010");
        
        -- set B, imm
        opcode <= "00000101";
        immediate <= "11010011";  
        wait for 110ns;             
        assert(debug_output_reg_b = "11010011");
        
        -- set B, A        
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000010";
        wait for 100ns;
        assert(debug_output_reg_b = "10101010");
  
        -- set A, B
        opcode <= "00000000";
        immediate <= "00000000";       
        wait for 100ns;
        opcode <= "00000001";
        wait for 100ns;
        assert(debug_output_reg_a = "10101010");            
        
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
        assert(debug_output_reg_a = "01000101");
    
        -- sub (11111111 - 10101010 = 01010101)
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "11111111";
        wait for 100ns;
        opcode <= "00000110";
        wait for 100ns;
        assert(debug_output_reg_a = "01010101");
        
        -- add (10101010 + 11010101 = 01111111)
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "11010101";
        wait for 100ns;
        opcode <= "00000111";        
        wait for 100ns;
        assert(debug_output_reg_a = "01111111");        
        
        -- and (11111111 & 10101010 = 10101010)
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "11111111";
        wait for 100ns;
        opcode <= "00001000";
        wait for 100ns;
        assert(debug_output_reg_a = "10101010");        
        
        -- or (10101010 || 01010101 = 11111111)
        opcode <= "00000101";
        immediate <= "01010101";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00001001";
        wait for 100ns;
        assert(debug_output_reg_a = "11111111");
        
        -- not (11011011 = 00100100)
        opcode <= "00000000";
        immediate <= "11011011";
        wait for 100ns;
        opcode <= "00001010";
        wait for 100ns;
        assert(debug_output_reg_a = "00100100");   
        
        -- xor (10101010 || 10101010 = 00000000)
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00001011";
        wait for 100ns;
        assert(debug_output_reg_a = "00000000");  
        
        -- prop B, 0
        opcode <= "00000101";
        immediate <= "10101010";
        wait for 100ns;
        opcode <= "00001100";
        wait for 100ns;
        assert(debug_output_reg_b = "00000000");
        
        opcode <= "00000101";
        immediate <= "00010101";
        wait for 100ns;
        opcode <= "00001100";
        wait for 100ns;
        assert(debug_output_reg_b = "11111111");               
        
        
        -- shl B (11010010 << 3 = 10010000)
        opcode <= "00000000";
        immediate <= "11010010";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "00000011";
        wait for 100ns;
        opcode <= "00010000";
        wait for 100ns;
        assert (debug_output_reg_a = "10010000");
        
        
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
