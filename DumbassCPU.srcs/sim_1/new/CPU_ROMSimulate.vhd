library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_ROMSimulate is
--  Port ( );
end CPU_ROMSimulate;

architecture Behavioral of CPU_ROMSimulate is

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
    program_counter_out,
    placeholder_byte
    : std_logic_vector(7 downto 0);
signal 
    clk,
    placeholder_bit
    : std_logic;

begin
    cpu_m: CPU port map(
        clk => clk, 
        opcode => opcode, 
        immediate => immediate, 
        register_A_port_out => register_A_out, 
        program_counter_out => program_counter_out, 
        register_B_port_out => register_B_out,
        a_equal_b => placeholder_bit,
        a_greater_b => placeholder_bit,
        a_lesser_b => placeholder_bit
    );

    process is
    begin
        opcode <= "00000000";
        immediate <= "00000000";
        wait for 110ns;
        opcode <= "00111111";
        wait for 100ns;
        
        opcode <= "00000000";
        immediate <= "00000000";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "11000011";
        wait for 100ns;
        opcode <= "00000100";  
        wait for 100ns;
        
        opcode <= "00000000";
        immediate <= "00000001";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "11100011";
        wait for 100ns;   
        opcode <= "00000100";  
        wait for 100ns;
        
        opcode <= "00000000";
        immediate <= "00000010";
        wait for 100ns;
        opcode <= "00000101";
        immediate <= "00000000";
        wait for 100ns;   
        opcode <= "00000100";  
        wait for 100ns;

        opcode <= "10000000";
        wait for 100ns;
        wait;
    end process;

end Behavioral;
