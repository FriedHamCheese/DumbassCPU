library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramRom is Port(
    address : in std_logic_vector(7 downto 0);
    opcode : out std_logic_vector(7 downto 0);
    immediate : out std_logic_vector(7 downto 0)
);
end ProgramRom;

architecture Structural of ProgramRom is

component Core_ByteMultiplexer is Port(
    instruction_0_in, instruction_1_in, instruction_2_in, instruction_3_in, instruction_4_in, instruction_5_in, instruction_6_in, instruction_7_in,
    instruction_8_in, instruction_9_in, instruction_10_in, instruction_11_in, instruction_12_in, instruction_13_in, instruction_14_in, instruction_15_in,
    instruction_16_in, instruction_17_in, instruction_18_in, instruction_19_in, instruction_20_in, instruction_21_in, instruction_22_in, instruction_23_in,
    instruction_24_in, instruction_25_in, instruction_26_in, instruction_27_in, instruction_28_in, instruction_29_in, instruction_30_in, instruction_31_in,
    instruction_32_in, instruction_33_in, instruction_34_in, instruction_35_in, instruction_36_in, instruction_37_in, instruction_38_in, instruction_39_in,
    instruction_40_in, instruction_41_in, instruction_42_in, instruction_43_in, instruction_44_in, instruction_45_in, instruction_46_in, instruction_47_in,
    instruction_48_in, instruction_49_in, instruction_50_in, instruction_51_in, instruction_52_in, instruction_53_in, instruction_54_in, instruction_55_in,
    instruction_56_in, instruction_57_in, instruction_58_in, instruction_59_in, instruction_60_in, instruction_61_in, instruction_62_in, instruction_63_in    
    : in std_logic_vector(7 downto 0);
    selecting_bits: in std_logic_vector(7 downto 0);
    selected_byte: out std_logic_vector(7 downto 0)
);
end component;

begin

opcode_selector: Core_ByteMultiplexer port map(
    "00000000", "00000010", "00000000", "00001000", "00000000", "10000001", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    address, opcode
);

immediate_selector: Core_ByteMultiplexer port map(
    "10101010", "00000000", "11111111", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",   
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    address, immediate
);

end Structural;
