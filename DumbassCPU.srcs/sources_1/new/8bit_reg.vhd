library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- This 8bit_reg is basically one register. The entire 16x8 memory should consist of 16 of these.

entity reg8 is
    Port (
        clk : in  STD_LOGIC;
        we  : in  STD_LOGIC;            -- Write enable for the entire 8-bit register
        d   : in  STD_LOGIC_VECTOR(7 downto 0);
        q   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end reg8;

architecture Structural_reg8 of reg8 is
    component d_ff is
        Port (
            clk : in  STD_LOGIC;
            we  : in  STD_LOGIC;
            d   : in  STD_LOGIC;
            q   : out STD_LOGIC
        );
    end component;

    signal q_bits : STD_LOGIC_VECTOR(7 downto 0);
begin
    gen_ff: for i in 0 to 7 generate
        bit_ff: d_ff port map(
            clk => clk,
            we  => we,
            d   => d(i),
            q   => q_bits(i)
        );
    end generate;

    q <= q_bits;
end Structural_reg8;


