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

-- opcodes:
-- 0    set A, imm
-- 1    set A, B
-- 2    set B, A
-- 3    set A, mem[A]
-- 4    set mem[A], B
-- 5    set B, imm

-- 6    sub (A = A-B)
-- 7    add (A = A+B)

-- 8    and B (A = A and B)
-- 9    or B (A = A or B)
-- 10   not  (not A)
-- 11   xor B (A = A xor B)
-- 12 	prop B, 0

-- 16   shl B
-- 17   shr B
-- 18   mul A, B
-- 19   rdiv A, b

-- 62	nop
-- 63   set pc, A

-- 129  jmp A


-- ; inputs: mem[0] x mem[1]
-- ; output: mem[2] as product

-- 0
-- ; get operands loaded into a and b
-- set A, 1			; 00000000 00000001
-- set A, mem[A]	; 00000011
-- set B, A			; 00000010
-- set A, 0			; 00000000 00000000
-- set A, mem[A]	; 00000011
-- prop B, 0		; 00001100
-- and A, B			; 00001000
-- set B, A			; 00000010

-- 8
-- ; accumulated sum
-- set A, 2			; 00000000 00000010
-- set A, mem[A]	; 00000011	
-- add A, B			; 00000111
-- ; save new sum in B
-- set B, A			; 00000010	
-- set A, 2			; 00000000 00000010
-- set mem[A], B	; 00000100	
-- nop				; 00111110
-- nop				; 00111110

-- 16
-- ; shift first operand
-- set A, 0			; 00000000 00000000 
-- set A, mem[A]	; 00000011
-- set B, 1			; 00000101 00000001
-- shl A, B			; 00010000
-- set B, A			; 00000010
-- set A, 0			; 00000000 00000000
-- set mem[A], B	; 00000100	
-- nop				; 00111110

-- 32
-- ; shift second operand for prop B, 0
-- set A, 1			; 00000000 00000001
-- set A, mem[A]	; 00000011
-- set B, 1			; 00000101 00000001
-- shr A, B			; 00010001
-- set B, A			; 00000010
-- set A, 1			; 00000000 00000001
-- set mem[A], B	; 00000100	
-- nop				; 00111110

-- 40
-- set A, 0			; 00000000 00000000
-- jmp A			; 10000001

opcode_selector: Core_ByteMultiplexer port map(   
    "00000000", "00000011", "00000010", "00000000", "00000011", "00001100", "00001000", "00000010",     
    "00000000", "00000011", "00000111", "00000010", "00000000", "00000100", "00111110", "00111110",
    "00000000", "00000011", "00000101", "00010000", "00000010", "00000000", "00000100", "00111110",  
    "00000000", "00000011", "00000101", "00010001", "00000010", "00000000", "00000100", "00111110", 
    "00000000", "10000001", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    address, opcode
);

immediate_selector: Core_ByteMultiplexer port map(  
    "00000001", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000010", "00000000", "00000000", "00000000", "00000010", "00000000", "00000000", "00000000",
    "00000000", "00000000", "00000001", "00000000", "00000000", "00000000", "00000000", "00000000",  
    "00000001", "00000000", "00000001", "00000000", "00000000", "00000001", "00000000", "00000000",  
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",   
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",     
    "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000",    
    address, immediate
);

end Structural;
