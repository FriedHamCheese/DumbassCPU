----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2025 01:53:19 PM
-- Design Name: 
-- Module Name: k7seg - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSeg is
    Port (
        clk : in STD_LOGIC;
        a : in STD_LOGIC_VECTOR(7 downto 0);
        b : in STD_LOGIC_VECTOR(7 downto 0);
        seven_seg_led : out STD_LOGIC_VECTOR(6 downto 0);
        seven_seg_on : out STD_LOGIC_VECTOR(3 downto 0)
    );
end SevenSeg;

architecture Behavioral of SevenSeg is
    signal digit_select : INTEGER range 0 to 3 := 0;
    signal digit_value : STD_LOGIC_VECTOR(3 downto 0);
    signal refresh_counter : INTEGER := 0;
    constant REFRESH_RATE : INTEGER := 100000;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if refresh_counter < REFRESH_RATE then
                refresh_counter <= refresh_counter + 1;
            else
                refresh_counter <= 0;
                digit_select <= digit_select + 1;
                if digit_select = 4 then
                    digit_select <= 0;
                end if;
            end if;
        end if;
    end process;

    process(digit_select, a, b)
    begin
        case digit_select is
            when 0 =>
                digit_value <= a(3 downto 0);
                seven_seg_on <= "1110";
            when 1 =>
                digit_value <= a(7 downto 4);
                seven_seg_on <= "1101";
            when 2 =>
                digit_value <= b(3 downto 0);
                seven_seg_on <= "1011";
            when 3 =>
                digit_value <= b(7 downto 4);
                seven_seg_on <= "0111";
            when others =>
                digit_value <= "0000";
                seven_seg_on <= "1111";
        end case;
    end process;

    process(digit_value)
    begin
        case digit_value is
            when "0000" => seven_seg_led <= "1000000"; -- 0
            when "0001" => seven_seg_led <= "1111001"; -- 1
            when "0010" => seven_seg_led <= "0100100"; -- 2
            when "0011" => seven_seg_led <= "0110000"; -- 3
            when "0100" => seven_seg_led <= "0011001"; -- 4
            when "0101" => seven_seg_led <= "0010010"; -- 5
            when "0110" => seven_seg_led <= "0000010"; -- 6
            when "0111" => seven_seg_led <= "1111000"; -- 7
            when "1000" => seven_seg_led <= "0000000"; -- 8
            when "1001" => seven_seg_led <= "0010000"; -- 9
            when "1010" => seven_seg_led <= "0001000"; -- A
            when "1011" => seven_seg_led <= "0000011"; -- B
            when "1100" => seven_seg_led <= "1000110"; -- C
            when "1101" => seven_seg_led <= "0100001"; -- D
            when "1110" => seven_seg_led <= "0000110"; -- E
            when "1111" => seven_seg_led <= "0001110"; -- F
            when others => seven_seg_led <= "1111111"; -- Blank
        end case;
    end process;

end Behavioral;