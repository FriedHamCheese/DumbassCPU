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
    debug_output_reg_b
    --debug_output
    : out std_logic_vector(7 downto 0)
);
end component;

signal opcode, immediate, debug_output_reg_a, debug_output_reg_b: std_logic_vector(7 downto 0);
signal clk: std_logic;

begin
    cpu: CPUInterface port map(clk, opcode, immediate, debug_output_reg_a, debug_output_reg_b);

    proc: process is
    begin
        opcode <= "00000000";
        immediate <= "10101010";
        wait for 110ns;             
        assert(debug_output_reg_a = "10101010");
        
        opcode <= "00000010";
        wait for 100ns;
        assert(debug_output_reg_b = "10101010");
  
        opcode <= "00000000";
        immediate <= "00000000";
        wait for 100ns;
        assert(debug_output_reg_a = "00000000");
        
        opcode <= "00000001";
        wait for 100ns;
        assert(debug_output_reg_a = "10101010");
        
        
        wait for 500ns;
        opcode <= "00001010";
        wait for 100ns;
        assert(debug_output_reg_a = "01010101");
        
        opcode <= "00001001";               
        wait for 100ns;            
        assert(debug_output_reg_a = "11111111");
        
        opcode <= "00000010";
        wait for 100ns;
        
        opcode <= "00001011";
        wait for 100ns;  
        assert(debug_output_reg_a = "00000000");
    wait;
    end process proc;
end Behavioral;
