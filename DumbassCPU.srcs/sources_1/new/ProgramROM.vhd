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

begin

-- 0
-- set A, 0     00000000, 00000000
-- set B, 1     00000101, 00000001
-- add A, B     00000111
-- add A, B     00000111
-- add A, B     00000111
-- add A, B     00000111
-- add A, B     00000111
-- add A, B     00000111
-- A = 6
-- 8
-- shl A, B     00010000
-- shl A, B     00010000
-- shl A, B     00010000
-- shl A, B     00010000
-- shl A, B     00010000
-- shl A, B     00010000 (overflow)
-- set A, 0     00000000, 00000000
-- jmp A        10000001
-- 16

opcode_selector: Core_ByteMultiplexer port map(
    "00000000", "00000101", "00000111", "00000111", "00000111", "00000111", "00000111", "00000111",  
    "00010000", "00010000", "00010000", "00010000", "00010000", "00010000", "00000000", "10000001",    
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    address, opcode
);

immediate_selector: Core_ByteMultiplexer port map(
    "00000000", "00000001", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
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
