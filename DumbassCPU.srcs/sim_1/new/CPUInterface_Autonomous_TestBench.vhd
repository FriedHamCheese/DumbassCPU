library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPUInterface_Autonomous_TestBench is
--  Port ( );
end CPUInterface_Autonomous_TestBench;

architecture Behavioral of CPUInterface_Autonomous_TestBench is

component CPUInterface is Port(
    clk: in std_logic;
    opcode: in std_logic_vector(7 downto 0);
    immediate: in std_logic_vector(7 downto 0);
    debug_output_reg_a,
    debug_output,
    debug_output_reg_b
    : out std_logic_vector(7 downto 0)
);
end component;

signal opcode, immediate, debug_output_reg_a, debug_output_reg_b: std_logic_vector(7 downto 0);
signal debug_output : std_logic_vector (7 downto 0);
signal clk: std_logic;

begin
    cpu: CPUInterface port map(clk, opcode, immediate, debug_output_reg_a, debug_output, debug_output_reg_b);

    process is
    begin
        opcode <= "10000000";
        wait for 110ns;
    wait;
    end process;

end Behavioral;
