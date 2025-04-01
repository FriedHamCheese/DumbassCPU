----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2025 08:28:10 PM
-- Design Name: 
-- Module Name: ShiftLeftTB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ShiftLeft is
end tb_ShiftLeft;

architecture Behavioral of tb_ShiftLeft is
    component ShiftLeft
        Port (
            Input : in std_logic_vector(7 downto 0);
            Count : in std_logic_vector(7 downto 0);
            Output : out std_logic_vector(7 downto 0)
        );
    end component;

    signal Input  : std_logic_vector(7 downto 0) := (others => '0');
    signal Count  : std_logic_vector(7 downto 0) := (others => '0');
    signal Output : std_logic_vector(7 downto 0);

begin
    uut: ShiftLeft port map (
        Input => Input,
        Count => Count,
        Output => Output
    );

    stimulus: process
    begin
        -- Test Case 1: No shift
        Input <= "11001010";
        Count <= "00000000";
        wait for 10 ns;
        assert Output = "11001010" report "TC1: No shift failed" severity error;

        -- Test Case 2: Shift by 1
        Input <= "11001010";
        Count <= "00000001";
        wait for 10 ns;
        assert Output = "10010100" report "TC2: Shift 1 failed" severity error;

        -- Test Case 3: Shift by 4
        Input <= "11001010";
        Count <= "00000100";
        wait for 10 ns;
        assert Output = "10100000" report "TC3: Shift 4 failed" severity error;
        
        -- Special Case 1: All 0
        Input <= "00000000";
        Count <= "00000011";
        wait for 10 ns;
        assert Output = "00000000" report "Special Case 1: All 0 failed";

        -- Special Case 2: All 1
        Input <= "11111111";
        Count <= "00000101";
        wait for 10 ns;
        assert Output = "11100000" report "Special Case 2: All 1 failed";
        
        -- Special Case 3: shifting more than 7
        Input <= "11111111";
        Count <= "00001000";
        wait for 10 ns;
        assert Output = "00000000" report "Special Case 3: Shift 8 times failed";

        wait;
    end process;
end Behavioral;