
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Gestion_freq is
    port( clk : in STD_LOGIC;
          raz : in STD_LOGIC;
          CE_affichage : out STD_LOGIC;
          CE_perception : out STD_LOGIC);
end Gestion_freq;

architecture Behavioral of Gestion_freq is

signal cmpt : std_logic_vector(28 downto 0):="00000000000000000000000000000";
signal cpt : integer range 0 to 50000000;
signal CE : std_logic := '0';

begin

process(clk,RAZ)

begin
    if(raz = '0') then
    cmpt <="00000000000000000000000000000";
    cpt <= 0;
    
    elsif rising_edge(clk) then
        cmpt <= cmpt+1;
        
        if cpt < 50000000 then
            cpt <= cpt + 1;
        else
            cpt <=1;
        end if;
        
        if cpt = 1 then 
            CE <= not(CE);
        end if;
    end if;
    
end process;

CE_perception <= cmpt(14);
CE_affichage <= CE;

end Behavioral;
