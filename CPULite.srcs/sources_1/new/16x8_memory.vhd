library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory16x8 is
    Port (
        clk  : in  STD_LOGIC;
        we   : in  STD_LOGIC;  -- Write Enable
        addr : in  STD_LOGIC_VECTOR(3 downto 0);
        din  : in  STD_LOGIC_VECTOR(7 downto 0);
        dout : out STD_LOGIC_VECTOR(7 downto 0)
    );
end memory16x8;

architecture Structural_mem of memory16x8 is

    -- Subcomponents
    component reg8
        Port (
            clk : in  STD_LOGIC;
            we  : in  STD_LOGIC;
            d   : in  STD_LOGIC_VECTOR(7 downto 0);
            q   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component decoder4x16 is
        Port (
            addr    : in  STD_LOGIC_VECTOR(3 downto 0);
            en      : in  STD_LOGIC;
            out_dec : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component mux_16to1_8 is
        Port (
            data_in : in  STD_LOGIC_VECTOR(127 downto 0);
            sel     : in  STD_LOGIC_VECTOR(15 downto 0);
            data_out: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- 16 registers of 8 bits each (128 bits total)
    signal regs_out : STD_LOGIC_VECTOR(16*8-1 downto 0);

    -- Decoder output for writing (one-hot select out of 16)
    signal dec_out : STD_LOGIC_VECTOR(15 downto 0);

    -- Decoder output for reading data
    signal read_sel : STD_LOGIC_VECTOR(15 downto 0);

begin

    -- Write decoder: Select which register gets we='1' (Write = 1, or true)
    dec_4x16: decoder4x16
        port map (
            addr    => addr,
            en      => we,       -- Master Write Enable
            out_dec => dec_out
        );

    -- Read decoder: Always enabled so we get a one-hot read select
    read_dec: decoder4x16
        port map (
            addr    => addr,
            en      => '1',
            out_dec => read_sel
        );

    -- Generate 16 registers.
    gen_registers: for i in 0 to 15 generate
        reg_inst: reg8
            port map (
                clk => clk,
                we  => dec_out(i),         -- Only the selected register writes
                d   => din,
                q   => regs_out((i+1)*8-1 downto i*8)
            );
    end generate;

    -- 16-to-1 multiplexer: selects which register's output goes to dout
    mux_16to1: mux_16to1_8
        port map (
            data_in => regs_out,
            sel     => read_sel,
            data_out=> dout
        );

end Structural_mem;
