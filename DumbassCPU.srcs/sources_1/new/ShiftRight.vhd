library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRight is
    Port ( Input : in std_logic_vector(7 downto 0);
           Count : in std_logic_vector(7 downto 0);
           Output : out std_logic_vector(7 downto 0));
end ShiftRight;

architecture dataflow of ShiftRight is
    signal stage0_out : std_logic_vector(7 downto 0);
    signal stage1_out : std_logic_vector(7 downto 0);
    signal stage2_out : std_logic_vector(7 downto 0);
    
    signal stage0_nosh : std_logic_vector(7 downto 0);
    signal stage0_sh1  : std_logic_vector(7 downto 0);
    
    signal stage1_nosh : std_logic_vector(7 downto 0);
    signal stage1_sh2  : std_logic_vector(7 downto 0);
    
    signal stage2_nosh : std_logic_vector(7 downto 0);
    signal stage2_sh4  : std_logic_vector(7 downto 0);
    
    signal valid_shift : std_logic;
begin
    valid_shift <= not (Count(7) or Count(6) or Count(5) or Count(4) or Count(3));
    
    stage0_nosh <= Input;
    stage0_sh1(7) <= '0';
    stage0_sh1(6) <= Input(7);
    stage0_sh1(5) <= Input(6);
    stage0_sh1(4) <= Input(5);
    stage0_sh1(3) <= Input(4);
    stage0_sh1(2) <= Input(3);
    stage0_sh1(1) <= Input(2);
    stage0_sh1(0) <= Input(1);
    
    stage0_out(7) <= (not Count(0) and stage0_nosh(7)) or (Count(0) and stage0_sh1(7));
    stage0_out(6) <= (not Count(0) and stage0_nosh(6)) or (Count(0) and stage0_sh1(6));
    stage0_out(5) <= (not Count(0) and stage0_nosh(5)) or (Count(0) and stage0_sh1(5));
    stage0_out(4) <= (not Count(0) and stage0_nosh(4)) or (Count(0) and stage0_sh1(4));
    stage0_out(3) <= (not Count(0) and stage0_nosh(3)) or (Count(0) and stage0_sh1(3));
    stage0_out(2) <= (not Count(0) and stage0_nosh(2)) or (Count(0) and stage0_sh1(2));
    stage0_out(1) <= (not Count(0) and stage0_nosh(1)) or (Count(0) and stage0_sh1(1));
    stage0_out(0) <= (not Count(0) and stage0_nosh(0)) or (Count(0) and stage0_sh1(0));
    
    stage1_nosh <= stage0_out;
    stage1_sh2(7) <= '0';
    stage1_sh2(6) <= '0';
    stage1_sh2(5) <= stage0_out(7);
    stage1_sh2(4) <= stage0_out(6);
    stage1_sh2(3) <= stage0_out(5);
    stage1_sh2(2) <= stage0_out(4);
    stage1_sh2(1) <= stage0_out(3);
    stage1_sh2(0) <= stage0_out(2);
    
    stage1_out(7) <= (not Count(1) and stage1_nosh(7)) or (Count(1) and stage1_sh2(7));
    stage1_out(6) <= (not Count(1) and stage1_nosh(6)) or (Count(1) and stage1_sh2(6));
    stage1_out(5) <= (not Count(1) and stage1_nosh(5)) or (Count(1) and stage1_sh2(5));
    stage1_out(4) <= (not Count(1) and stage1_nosh(4)) or (Count(1) and stage1_sh2(4));
    stage1_out(3) <= (not Count(1) and stage1_nosh(3)) or (Count(1) and stage1_sh2(3));
    stage1_out(2) <= (not Count(1) and stage1_nosh(2)) or (Count(1) and stage1_sh2(2));
    stage1_out(1) <= (not Count(1) and stage1_nosh(1)) or (Count(1) and stage1_sh2(1));
    stage1_out(0) <= (not Count(1) and stage1_nosh(0)) or (Count(1) and stage1_sh2(0));
    
    stage2_nosh <= stage1_out;
    stage2_sh4(7) <= '0';
    stage2_sh4(6) <= '0';
    stage2_sh4(5) <= '0';
    stage2_sh4(4) <= '0';
    stage2_sh4(3) <= stage1_out(7);
    stage2_sh4(2) <= stage1_out(6);
    stage2_sh4(1) <= stage1_out(5);
    stage2_sh4(0) <= stage1_out(4);
    
    stage2_out(7) <= (not Count(2) and stage2_nosh(7)) or (Count(2) and stage2_sh4(7));
    stage2_out(6) <= (not Count(2) and stage2_nosh(6)) or (Count(2) and stage2_sh4(6));
    stage2_out(5) <= (not Count(2) and stage2_nosh(5)) or (Count(2) and stage2_sh4(5));
    stage2_out(4) <= (not Count(2) and stage2_nosh(4)) or (Count(2) and stage2_sh4(4));
    stage2_out(3) <= (not Count(2) and stage2_nosh(3)) or (Count(2) and stage2_sh4(3));
    stage2_out(2) <= (not Count(2) and stage2_nosh(2)) or (Count(2) and stage2_sh4(2));
    stage2_out(1) <= (not Count(2) and stage2_nosh(1)) or (Count(2) and stage2_sh4(1));
    stage2_out(0) <= (not Count(2) and stage2_nosh(0)) or (Count(2) and stage2_sh4(0));
    
    Output(7) <= stage2_out(7) and valid_shift;
    Output(6) <= stage2_out(6) and valid_shift;
    Output(5) <= stage2_out(5) and valid_shift;
    Output(4) <= stage2_out(4) and valid_shift;
    Output(3) <= stage2_out(3) and valid_shift;
    Output(2) <= stage2_out(2) and valid_shift;
    Output(1) <= stage2_out(1) and valid_shift;
    Output(0) <= stage2_out(0) and valid_shift;
end dataflow;
