-- 16 bit multiplexer. Gets 1 output signal from selecting 16 different registers, in this case, when one address is selected, it contains 8 bits. Utilizes "AndEightBitByOneBit"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16to1_8 is
    Port (
        data_in : in  STD_LOGIC_VECTOR(127 downto 0); -- 16 words × 8 bits = 128 bits
        sel     : in  STD_LOGIC_VECTOR(15 downto 0);  -- One-hot select: 16 bits
        data_out: out STD_LOGIC_VECTOR(7 downto 0)     -- 8-bit output
    );
end mux_16to1_8;

architecture Dataflow of mux_16to1_8 is

    -- This component ANDs an 8-bit vector with a one-bit control.
    component AndEightBitByOneBit is
        Port(
            eight_bits : in  STD_LOGIC_VECTOR(7 downto 0);
            one_bit    : in  STD_LOGIC;
            output     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    -- Signal to collect outputs from each AND block.
    signal and_outputs : STD_LOGIC_VECTOR(127 downto 0);
    
begin
    -- Generate 16 blocks: one per 8-bit word.
    gen_and: for i in 0 to 15 generate
        and_inst: AndEightBitByOneBit
            port map(
                eight_bits => data_in(i*8+7 downto i*8),
                one_bit    => sel(i),
                output     => and_outputs(i*8+7 downto i*8)
            );
    end generate;

    -- OR all 16 8-bit outputs together.
    data_out <= and_outputs(7 downto 0) or
                and_outputs(15 downto 8) or
                and_outputs(23 downto 16) or
                and_outputs(31 downto 24) or
                and_outputs(39 downto 32) or
                and_outputs(47 downto 40) or
                and_outputs(55 downto 48) or
                and_outputs(63 downto 56) or
                and_outputs(71 downto 64) or
                and_outputs(79 downto 72) or
                and_outputs(87 downto 80) or
                and_outputs(95 downto 88) or
                and_outputs(103 downto 96) or
                and_outputs(111 downto 104) or
                and_outputs(119 downto 112) or
                and_outputs(127 downto 120);

end Dataflow;




--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- This basically manages, which, out of all 16 addresses output gets displayed, 8 bits per address. (Total of 128 bits)

--entity mux16to1_8 is
--    Port (
--        data_in : in  STD_LOGIC_VECTOR(16*8-1 downto 0);
--        sel     : in  STD_LOGIC_VECTOR(3 downto 0);
--        data_out: out STD_LOGIC_VECTOR(7 downto 0)
--    );
--end mux16to1_8;

--architecture Behavioral_mux of mux16to1_8 is
--begin
--    process(data_in, sel)
--        variable temp : STD_LOGIC_VECTOR(7 downto 0);
--    begin
--        case sel is
--            when "0000" => temp := data_in(7 downto 0);
--            when "0001" => temp := data_in(15 downto 8);
--            when "0010" => temp := data_in(23 downto 16);
--            when "0011" => temp := data_in(31 downto 24);
--            when "0100" => temp := data_in(39 downto 32);
--            when "0101" => temp := data_in(47 downto 40);
--            when "0110" => temp := data_in(55 downto 48);
--            when "0111" => temp := data_in(63 downto 56);
--            when "1000" => temp := data_in(71 downto 64);
--            when "1001" => temp := data_in(79 downto 72);
--            when "1010" => temp := data_in(87 downto 80);
--            when "1011" => temp := data_in(95 downto 88);
--            when "1100" => temp := data_in(103 downto 96);
--            when "1101" => temp := data_in(111 downto 104);
--            when "1110" => temp := data_in(119 downto 112);
--            when "1111" => temp := data_in(127 downto 120);
--            when others => temp := (others => '0');
--        end case;
--        data_out <= temp;
--    end process;
--end Behavioral_mux;