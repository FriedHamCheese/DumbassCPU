library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RoughDivide is
    Port ( Dividend : in std_logic_vector(7 downto 0);
           Divisor : in std_logic_vector(7 downto 0);
           Quotient : out std_logic_vector(7 downto 0));
end RoughDivide;

architecture dataflow of RoughDivide is
    -- ShiftRight component
    component ShiftRight is
        Port ( Input : in std_logic_vector(7 downto 0);
               Count : in std_logic_vector(7 downto 0);
               Output : out std_logic_vector(7 downto 0));
    end component;
    
    -- log2 approximation signals
    signal log2_divisor : std_logic_vector(7 downto 0);
    
    -- Priority encoder for log2 approximation
    signal is_bit7 : std_logic;
    signal is_bit6 : std_logic;
    signal is_bit5 : std_logic;
    signal is_bit4 : std_logic;
    signal is_bit3 : std_logic;
    signal is_bit2 : std_logic;
    signal is_bit1 : std_logic;
    signal is_bit0 : std_logic;
    
begin
    -- Find the most significant '1' bit in the divisor (priority encoder)
    is_bit7 <= Divisor(7);
    is_bit6 <= Divisor(6) and not is_bit7;
    is_bit5 <= Divisor(5) and not (is_bit7 or is_bit6);
    is_bit4 <= Divisor(4) and not (is_bit7 or is_bit6 or is_bit5);
    is_bit3 <= Divisor(3) and not (is_bit7 or is_bit6 or is_bit5 or is_bit4);
    is_bit2 <= Divisor(2) and not (is_bit7 or is_bit6 or is_bit5 or is_bit4 or is_bit3);
    is_bit1 <= Divisor(1) and not (is_bit7 or is_bit6 or is_bit5 or is_bit4 or is_bit3 or is_bit2);
    is_bit0 <= Divisor(0) and not (is_bit7 or is_bit6 or is_bit5 or is_bit4 or is_bit3 or is_bit2 or is_bit1);
    
    -- Encode position of MSB as log2 approximation
    log2_divisor(7 downto 3) <= "00000";
    log2_divisor(2) <= is_bit7 or is_bit6 or is_bit5 or is_bit4;
    log2_divisor(1) <= is_bit7 or is_bit6 or is_bit3 or is_bit2;
    log2_divisor(0) <= is_bit7 or is_bit5 or is_bit3 or is_bit1;
    
    -- Perform division by shifting right by log2(divisor)
    divider: ShiftRight port map (
        Input => Dividend,
        Count => log2_divisor,
        Output => Quotient
    );
    
end dataflow;