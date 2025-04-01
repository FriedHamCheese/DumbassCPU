library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Subtracter is
    Port (
        A : in  STD_LOGIC_VECTOR (7 downto 0);
        B : in  STD_LOGIC_VECTOR (7 downto 0);
        Difference : out  STD_LOGIC_VECTOR (7 downto 0);
        Borrow : out  STD_LOGIC
    );
end Subtracter;

architecture Dataflow of Subtracter is
    signal B_inv : STD_LOGIC_VECTOR (7 downto 0);
    signal Sum : STD_LOGIC_VECTOR (8 downto 0);
    signal Carry : STD_LOGIC_VECTOR (8 downto 0);
begin
    B_inv <= not B;

    -- Perform bitwise addition with carry calculation
    Carry(0) <= '1'; -- Initial carry-in is 1
    Sum(0) <= A(0) xor B_inv(0) xor Carry(0);
    Carry(1) <= (A(0) and B_inv(0)) or (B_inv(0) and Carry(0)) or (Carry(0) and A(0));

    Sum(1) <= A(1) xor B_inv(1) xor Carry(1);
    Carry(2) <= (A(1) and B_inv(1)) or (B_inv(1) and Carry(1)) or (Carry(1) and A(1));

    Sum(2) <= A(2) xor B_inv(2) xor Carry(2);
    Carry(3) <= (A(2) and B_inv(2)) or (B_inv(2) and Carry(2)) or (Carry(2) and A(2));

    Sum(3) <= A(3) xor B_inv(3) xor Carry(3);
    Carry(4) <= (A(3) and B_inv(3)) or (B_inv(3) and Carry(3)) or (Carry(3) and A(3));

    Sum(4) <= A(4) xor B_inv(4) xor Carry(4);
    Carry(5) <= (A(4) and B_inv(4)) or (B_inv(4) and Carry(4)) or (Carry(4) and A(4));

    Sum(5) <= A(5) xor B_inv(5) xor Carry(5);
    Carry(6) <= (A(5) and B_inv(5)) or (B_inv(5) and Carry(5)) or (Carry(5) and A(5));

    Sum(6) <= A(6) xor B_inv(6) xor Carry(6);
    Carry(7) <= (A(6) and B_inv(6)) or (B_inv(6) and Carry(6)) or (Carry(6) and A(6));

    Sum(7) <= A(7) xor B_inv(7) xor Carry(7);
    Carry(8) <= (A(7) and B_inv(7)) or (B_inv(7) and Carry(7)) or (Carry(7) and A(7));

    -- Assign the difference and borrow
    Difference <= Sum(7 downto 0);
    Borrow <= not Carry(8);
end Dataflow;
