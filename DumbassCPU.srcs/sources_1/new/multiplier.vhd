library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Multiplier8Bit is
    Port (
        a : in  STD_LOGIC_VECTOR (7 downto 0);
        b : in  STD_LOGIC_VECTOR (7 downto 0);
        c : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Multiplier8Bit;

architecture Structural of Multiplier8Bit is
    signal p0, p1, p2, p3, p4, p5, p6, p7 : STD_LOGIC_VECTOR(15 downto 0);
    signal sum1, sum2, sum3, sum4, sum5, sum6, sum7 : STD_LOGIC_VECTOR(15 downto 0);
begin
    -- Generate Partial Products
    p0 <= ("00000000" & (b and (7 downto 0 => a(0))));
    p1 <= ("0000000" & (b and (7 downto 0 => a(1))) & "0");
    p2 <= ("000000" & (b and (7 downto 0 => a(2))) & "00");
    p3 <= ("00000" & (b and (7 downto 0 => a(3))) & "000");
    p4 <= ("0000" & (b and (7 downto 0 => a(4))) & "0000");
    p5 <= ("000" & (b and (7 downto 0 => a(5))) & "00000");
    p6 <= ("00" & (b and (7 downto 0 => a(6))) & "000000");
    p7 <= ("0" & (b and (7 downto 0 => a(7))) & "0000000");

    -- Instantiate Adder Modules
    adder1: entity work.Adder8Bit
        port map (
            a => p0(7 downto 0),
            b => p1(7 downto 0),
            cin => '0',
            sum => sum1(7 downto 0),
            cout => open
        );

    adder2: entity work.Adder8Bit
        port map (
            a => sum1(7 downto 0),
            b => p2(7 downto 0),
            cin => '0',
            sum => sum2(7 downto 0),
            cout => open
        );

    adder3: entity work.Adder8Bit
        port map (
            a => sum2(7 downto 0),
            b => p3(7 downto 0),
            cin => '0',
            sum => sum3(7 downto 0),
            cout => open
        );

    adder4: entity work.Adder8Bit
        port map (
            a => sum3(7 downto 0),
            b => p4(7 downto 0),
            cin => '0',
            sum => sum4(7 downto 0),
            cout => open
        );

    adder5: entity work.Adder8Bit
        port map (
            a => sum4(7 downto 0),
            b => p5(7 downto 0),
            cin => '0',
            sum => sum5(7 downto 0),
            cout => open
        );

    adder6: entity work.Adder8Bit
        port map (
            a => sum5(7 downto 0),
            b => p6(7 downto 0),
            cin => '0',
            sum => sum6(7 downto 0),
            cout => open
        );

    adder7: entity work.Adder8Bit
        port map (
            a => sum6(7 downto 0),
            b => p7(7 downto 0),
            cin => '0',
            sum => sum7(7 downto 0),
            cout => open
        );

    -- Output lower 8 bits
    c <= sum7(7 downto 0);
end Structural;
