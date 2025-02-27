library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ByteRegister is Port(
    data_in: in std_logic_vector(7 downto 0);
    overwrite: in std_logic;
    rising_edge_clk: in std_logic;
    data_out: out std_logic_vector(7 downto 0)
);
end ByteRegister;

architecture Structural of ByteRegister is

component OneBitDFlipFlop is Port(
    bit_in: in std_logic;
    rising_edge_clk: in std_logic;
    overwrite: in std_logic;
    bit_out: out std_logic
);
end component;

begin
    bit_7: OneBitDFlipFlop port map(data_in(7), rising_edge_clk, overwrite, data_out(7));
    bit_6: OneBitDFlipFlop port map(data_in(6), rising_edge_clk, overwrite, data_out(6));
    bit_5: OneBitDFlipFlop port map(data_in(5), rising_edge_clk, overwrite, data_out(5));
    bit_4: OneBitDFlipFlop port map(data_in(4), rising_edge_clk, overwrite, data_out(4));
    bit_3: OneBitDFlipFlop port map(data_in(3), rising_edge_clk, overwrite, data_out(3));
    bit_2: OneBitDFlipFlop port map(data_in(2), rising_edge_clk, overwrite, data_out(2));
    bit_1: OneBitDFlipFlop port map(data_in(1), rising_edge_clk, overwrite, data_out(1));
    bit_0: OneBitDFlipFlop port map(data_in(0), rising_edge_clk, overwrite, data_out(0));

end Structural;
