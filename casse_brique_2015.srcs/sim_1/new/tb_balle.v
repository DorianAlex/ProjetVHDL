-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 15.12.2020 13:57:16 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_balle is
end tb_balle;

architecture tb of tb_balle is

    component balle
        port (xpos    : in std_logic_vector (9 downto 0);
              ypos    : in std_logic_vector (9 downto 0);
              clk     : in std_logic;
              x_balle : in std_logic_vector (10 downto 0);
              y_balle : in std_logic_vector (10 downto 0);
              dedans  : out std_logic);
    end component;

    signal xpos    : std_logic_vector (9 downto 0);
    signal ypos    : std_logic_vector (9 downto 0);
    signal clk     : std_logic;
    signal x_balle : std_logic_vector (10 downto 0);
    signal y_balle : std_logic_vector (10 downto 0);
    signal dedans  : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : balle
    port map (xpos    => xpos,
              ypos    => ypos,
              clk     => clk,
              x_balle => x_balle,
              y_balle => y_balle,
              dedans  => dedans);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        xpos <= "000111111";
        ypos <= "000111111";
        x_balle <= "00001111110";
        y_balle <= "00001111110";

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulatio
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_balle of tb_balle is
    for tb
    end for;
end cfg_tb_balle;