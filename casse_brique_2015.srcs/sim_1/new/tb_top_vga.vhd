-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 8.1.2021 13:07:45 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_vga is
end tb_top_vga;

architecture tb of tb_top_vga is

    component top_vga
        port (clk       : in std_logic;
              reset     : in std_logic;
              bouton    : in std_logic;
              red_o     : out std_logic;
              green_o   : out std_logic;
              blue_o    : out std_logic;
              hsync     : out std_logic;
              vsync     : out std_logic;
              SCLK      : out std_logic;
              MOSI      : out std_logic;
              MISO      : in std_logic;
              px        : out std_logic_vector (1 downto 0);
              py        : out std_logic_vector (1 downto 0);
              ACCEL_Y_o : out std_logic_vector (10 downto 0);
              gagne     : in std_logic;
              test      : out std_logic;
              SS        : out std_logic);
    end component;

    signal clk       : std_logic;
    signal reset     : std_logic;
    signal bouton    : std_logic;
    signal red_o     : std_logic;
    signal green_o   : std_logic;
    signal blue_o    : std_logic;
    signal hsync     : std_logic;
    signal vsync     : std_logic;
    signal SCLK      : std_logic;
    signal MOSI      : std_logic;
    signal MISO      : std_logic;
    signal px        : std_logic_vector (1 downto 0);
    signal py        : std_logic_vector (1 downto 0);
    signal ACCEL_Y_o : std_logic_vector (10 downto 0);
    signal gagne     : std_logic;
    signal test      : std_logic;
    signal SS        : std_logic;

    constant TbPeriod : time := 10ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_vga
    port map (clk       => clk,
              reset     => reset,
              bouton    => bouton,
              red_o     => red_o,
              green_o   => green_o,
              blue_o    => blue_o,
              hsync     => hsync,
              vsync     => vsync,
              SCLK      => SCLK,
              MOSI      => MOSI,
              MISO      => MISO,
              px        => px,
              py        => py,
              ACCEL_Y_o => ACCEL_Y_o,
              gagne     => gagne,
              test      => test,
              SS        => SS);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        bouton <= '0';
        MISO <= '0';
        gagne <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;
        bouton <= '1';
        wait for 100ns;
        reset <= '0';

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
    
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_top_vga of tb_top_vga is
    for tb
    end for;
end cfg_tb_top_vga;