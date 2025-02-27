library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionInputByteSelector_UnitTest is
end InstructionInputByteSelector_UnitTest; 

architecture Behavioral of InstructionInputByteSelector_UnitTest is

component InstructionInputByteSelector is Port(
    input_byte: in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector (3 downto 0);
    instruction_0_out,
    instruction_1_out,
    instruction_2_out,
    instruction_3_out,
    instruction_4_out,
    instruction_5_out,
    instruction_6_out,
    instruction_7_out,
    instruction_8_out,
    instruction_9_out,
    instruction_10_out,
    instruction_11_out,
    instruction_12_out,
    instruction_13_out,
    instruction_14_out,
    instruction_15_out
    : out std_logic_vector (7 downto 0)
);
end component;

type InstructionOut is array(15 downto 0) of std_logic_vector(7 downto 0);
signal instruction_out: InstructionOut;
signal input_byte: std_logic_vector(7 downto 0);
signal selecting_bits: std_logic_vector(3 downto 0);

constant all_zeros: std_logic_vector(7 downto 0) := "00000000";

begin
    selector: InstructionInputByteSelector port map(
        input_byte,
        selecting_bits,
        instruction_out(0),
        instruction_out(1),
        instruction_out(2),
        instruction_out(3),
        instruction_out(4),
        instruction_out(5),
        instruction_out(6),
        instruction_out(7),
        instruction_out(8),
        instruction_out(9),
        instruction_out(10),
        instruction_out(11),
        instruction_out(12),
        instruction_out(13),
        instruction_out(14),
        instruction_out(15)
    );

	proc: process is
	begin
	   assert(false = true)
	   report "---- InstructionInputByteSelector_UnitTest Begin ----"
	   severity note;
	
        input_byte <= "10101010";
        selecting_bits <= "0000";
        wait for 20ns;
        assert(
            instruction_out(0) =  "10101010"
            and instruction_out(1) =  all_zeros
            and instruction_out(2) =  all_zeros
            and instruction_out(3) =  all_zeros
            and instruction_out(4) =  all_zeros
            and instruction_out(5) =  all_zeros
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  all_zeros
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 0"
        severity error;
 
        input_byte <= "10101010";
        selecting_bits <= "0001";
        wait for 20ns;
        assert(
            instruction_out(0) =      all_zeros
            and instruction_out(1) =  "10101010"
            and instruction_out(2) =  all_zeros
            and instruction_out(3) =  all_zeros
            and instruction_out(4) =  all_zeros
            and instruction_out(5) =  all_zeros
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  all_zeros
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 1"
        severity error;
 
         input_byte <= "10101010";
        selecting_bits <= "0010";
        wait for 20ns;
        assert(
            instruction_out(0) =      all_zeros
            and instruction_out(1) =  all_zeros
            and instruction_out(2) =  "10101010"
            and instruction_out(3) =  all_zeros
            and instruction_out(4) =  all_zeros
            and instruction_out(5) =  all_zeros
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  all_zeros
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 2"
        severity error;
        
        input_byte <= "10101010";
        selecting_bits <= "0011";
        wait for 20ns;
        assert(
            instruction_out(0) =      all_zeros
            and instruction_out(1) =  all_zeros
            and instruction_out(2) =  all_zeros
            and instruction_out(3) =  "10101010"
            and instruction_out(4) =  all_zeros
            and instruction_out(5) =  all_zeros
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  all_zeros
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 3"
        severity error;
        
        input_byte <= "10101010";
        selecting_bits <= "0100";
        wait for 20ns;
        assert(
            instruction_out(0) =      all_zeros
            and instruction_out(1) =  all_zeros
            and instruction_out(2) =  all_zeros
            and instruction_out(3) =  all_zeros
            and instruction_out(4) =  "10101010"
            and instruction_out(5) =  all_zeros
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  all_zeros
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 4"
        severity error;

        input_byte <= "10101010";
        selecting_bits <= "0101";
        wait for 20ns;
        assert(
            instruction_out(0) =      all_zeros
            and instruction_out(1) =  all_zeros
            and instruction_out(2) =  all_zeros
            and instruction_out(3) =  all_zeros
            and instruction_out(4) =  all_zeros
            and instruction_out(5) =  "10101010"
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  all_zeros
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 5"
        severity error;
        
        input_byte <= "10101010";
        selecting_bits <= "1000";
        wait for 20ns;
        assert(
            instruction_out(0) =      all_zeros
            and instruction_out(1) =  all_zeros
            and instruction_out(2) =  all_zeros
            and instruction_out(3) =  all_zeros
            and instruction_out(4) =  all_zeros
            and instruction_out(5) =  all_zeros
            and instruction_out(6) =  all_zeros
            and instruction_out(7) =  all_zeros
            and instruction_out(8) =  "10101010"
            and instruction_out(9) =  all_zeros
            and instruction_out(10) = all_zeros
            and instruction_out(11) = all_zeros
            and instruction_out(12) = all_zeros
            and instruction_out(13) = all_zeros
            and instruction_out(14) = all_zeros           
            and instruction_out(15) = all_zeros
        )
        report "InstructionInputByteSelector_UnitTest: Failed at case 8"
        severity error;
        
	    assert(false = true)
        report "---- InstructionInputByteSelector_UnitTest End ----"
        severity note;
        
        wait;
	end process proc;
end Behavioral;
