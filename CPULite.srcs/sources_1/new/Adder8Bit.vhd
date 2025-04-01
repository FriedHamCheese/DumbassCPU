library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder8Bit is
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        Cin : in  STD_LOGIC;
        Sum : out  STD_LOGIC_VECTOR (7 downto 0);
        Cout : out  STD_LOGIC
    );
end Adder8Bit;

architecture Dataflow of Adder8Bit is
    signal Carry : STD_LOGIC_VECTOR (7 downto 0);
begin

     Sum(0) <= A(0) xor B(0) xor Cin;
    Carry(0) <= (A(0) and B(0)) or (Cin and (A(0) xor B(0)));

    Sum(1) <= A(1) xor B(1) xor Carry(0);
    Carry(1) <= (A(1) and B(1)) or (Carry(0) and (A(1) xor B(1)));

    Sum(2) <= A(2) xor B(2) xor Carry(1);
    Carry(2) <= (A(2) and B(2)) or (Carry(1) and (A(2) xor B(2)));

    Sum(3) <= A(3) xor B(3) xor Carry(2);
    Carry(3) <= (A(3) and B(3)) or (Carry(2) and (A(3) xor B(3)));

    Sum(4) <= A(4) xor B(4) xor Carry(3);
    Carry(4) <= (A(4) and B(4)) or (Carry(3) and (A(4) xor B(4)));

    Sum(5) <= A(5) xor B(5) xor Carry(4);
    Carry(5) <= (A(5) and B(5)) or (Carry(4) and (A(5) xor B(5)));

    Sum(6) <= A(6) xor B(6) xor Carry(5);
    Carry(6) <= (A(6) and B(6)) or (Carry(5) and (A(6) xor B(6)));

    Sum(7) <= A(7) xor B(7) xor Carry(6);
    Carry(7) <= (A(7) and B(7)) or (Carry(6) and (A(7) xor B(7)));

    Cout <= Carry(7);
end Dataflow;