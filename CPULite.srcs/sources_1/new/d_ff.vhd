library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- This is the switch, holding one singular bit.

entity d_ff is
    Port (
        clk : in  STD_LOGIC;
        we  : in  STD_LOGIC;   -- Write enable for this flip-flop (1 = can write, 0 = cannot write/ignore)
        d   : in  STD_LOGIC;   -- Data input
        q   : out STD_LOGIC    -- Data output
    );
end d_ff;

architecture Behavioral_ff of d_ff is
    signal q_int : STD_LOGIC := '0';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                q_int <= d;
            end if;
        end if;
    end process;
    q <= q_int;
end Behavioral_ff;