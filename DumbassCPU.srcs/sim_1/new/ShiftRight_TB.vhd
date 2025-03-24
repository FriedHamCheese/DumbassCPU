library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftRight_TB is
end ShiftRight_TB;

architecture test of ShiftRight_TB is
    -- Component Declaration for ShiftRight
    component ShiftRight
        Port ( Input  : in std_logic_vector(7 downto 0);
               Count  : in std_logic_vector(7 downto 0);
               Output : out std_logic_vector(7 downto 0));
    end component;
    
    -- Test Signals
    signal Input  : std_logic_vector(7 downto 0);
    signal Count  : std_logic_vector(7 downto 0);
    signal Output : std_logic_vector(7 downto 0);
    
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: ShiftRight port map (
        Input  => Input,
        Count  => Count,
        Output => Output
    );
    
    -- Stimulus Process
    process
    begin
        -- Test Case 1: No shift
        Input <= "10101010"; -- 0xAA (170 in decimal)
        Count <= "00000000"; -- Shift by 0
        wait for 10 ns;
        
        -- Test Case 2: Shift by 1
        Count <= "00000001";
        wait for 10 ns;
        
        -- Test Case 3: Shift by 2
        Count <= "00000010";
        wait for 10 ns;
        
        -- Test Case 4: Shift by 3
        Count <= "00000011";
        wait for 10 ns;
        
        -- Test Case 5: Shift by 7 (max shift in 8-bit range)
        Count <= "00000111";
        wait for 10 ns;
        
        -- Test Case 6: Shift by more than 7 (should behave as max shift)
        Count <= "00001000";
        wait for 10 ns;
        
        -- Test Case 7: All ones input
        Input <= "11111111";
        Count <= "00000010";
        wait for 10 ns;
        
        -- Test Case 8: Edge case - shifting zero
        Input <= "00000000";
        Count <= "00000100";
        wait for 10 ns;
        
        -- Stop simulation
        wait;
    end process;
    
end test;
