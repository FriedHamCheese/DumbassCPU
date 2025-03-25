-- This converts a 4-bit input into a 16-bit input, 1 representing the specific register its trying to read/write from.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder4x16 is
    Port (
        addr    : in  STD_LOGIC_VECTOR(3 downto 0);
        en      : in  STD_LOGIC;
        out_dec : out STD_LOGIC_VECTOR(15 downto 0)
    );
end decoder4x16;

architecture Dataflow of decoder4x16 is
begin
    -- process(addr, en)
    --     variable tmp : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    -- begin
    --     if en = '1' then
    --         case addr is
    --             when "0000" => tmp := "0000000000000001";
    --             when "0001" => tmp := "0000000000000010";
    --             when "0010" => tmp := "0000000000000100";
    --             when "0011" => tmp := "0000000000001000";
    --             when "0100" => tmp := "0000000000010000";
    --             when "0101" => tmp := "0000000000100000";
    --             when "0110" => tmp := "0000000001000000";
    --             when "0111" => tmp := "0000000010000000";
    --             when "1000" => tmp := "0000000100000000";
    --             when "1001" => tmp := "0000001000000000";
    --             when "1010" => tmp := "0000010000000000";
    --             when "1011" => tmp := "0000100000000000";
    --             when "1100" => tmp := "0001000000000000";
    --             when "1101" => tmp := "0010000000000000";
    --             when "1110" => tmp := "0100000000000000";
    --             when "1111" => tmp := "1000000000000000";
    --             when others => tmp := (others => '0');
    --         end case;
    --     else
    --         tmp := (others => '0');
    --     end if;
    --     out_dec <= tmp;
    -- end process;
	
	out_dec(0) <= en and (not addr(3)) and (not addr(2)) and (not addr(1)) and (not addr(0));		--0000
	out_dec(1) <= en and (not addr(3)) and (not addr(2)) and (not addr(1)) and (addr(0));			--0001	
	out_dec(2) <= en and (not addr(3)) and (not addr(2)) and (addr(1)) and (not addr(0));			--0010
	out_dec(3) <= en and (not addr(3)) and (not addr(2)) and (addr(1)) and (addr(0));				--0011
	out_dec(4) <= en and (not addr(3)) and (addr(2)) and (not addr(1)) and (not addr(0));			--0100
	out_dec(5) <= en and (not addr(3)) and (addr(2)) and (not addr(1)) and (addr(0));				--0101
	out_dec(6) <= en and (not addr(3)) and (addr(2)) and (addr(1)) and (not addr(0));				--0110	
	out_dec(7) <= en and (not addr(3)) and (addr(2)) and (addr(1)) and (addr(0));					--0111
	
	out_dec(8)  <= en and (addr(3)) and (not addr(2)) and (not addr(1)) and (not addr(0));			--1000	
	out_dec(9)  <= en and (addr(3)) and (not addr(2)) and (not addr(1)) and (addr(0));				--1001
	out_dec(10) <= en and (addr(3)) and (not addr(2)) and (addr(1)) and (not addr(0));				--1010
	out_dec(11) <= en and (addr(3)) and (not addr(2)) and (addr(1)) and (addr(0));					--1011	
	out_dec(12) <= en and (addr(3)) and (addr(2)) and (not addr(1)) and (not addr(0));				--1100
	out_dec(13) <= en and (addr(3)) and (addr(2)) and (not addr(1)) and (addr(0));					--1101
	out_dec(14) <= en and (addr(3)) and (addr(2)) and (addr(1)) and (not addr(0));					--1110
	out_dec(15) <= en and (addr(3)) and (addr(2)) and (addr(1)) and (addr(0));						--1111
	
end Dataflow;
