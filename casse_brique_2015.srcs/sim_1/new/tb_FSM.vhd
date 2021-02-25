-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 8.1.2021 15:53:10 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_FSM is
end tb_FSM;

architecture tb of tb_FSM is

    component FSM
        port (clk    : in std_logic;
              reset  : in std_logic;
              bouton : in std_logic;
              perdu  : in std_logic;
              gagner : in std_logic;
              en     : out std_logic;
              test   : out std_logic;
              fin    : out std_logic_vector (1 downto 0));
    end component;

    signal clk    : std_logic;
    signal reset  : std_logic;
    signal bouton : std_logic;
    signal perdu  : std_logic;
    signal gagner : std_logic;
    signal en     : std_logic;
    signal test   : std_logic;
    signal fin    : std_logic_vector (1 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : FSM
    port map (clk    => clk,
              reset  => reset,
              bouton => bouton,
              perdu  => perdu,
              gagner => gagner,
              en     => en,
              test   => test,
              fin    => fin);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        bouton <= '0';
        perdu <= '0';
        gagner <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;
        bouton <= '1';
        wait for 100 ns;
        bouton <= '0';
        wait for 100 ns;
        gagner <= '1';
        
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_FSM of tb_FSM is
    for tb
    end for;
end cfg_tb_FSM;