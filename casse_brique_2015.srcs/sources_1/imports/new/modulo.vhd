----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.09.2020 14:59:44
-- Design Name: 
-- Module Name: mod8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

entity modulo is
    Port ( clk : in STD_LOGIC;
           CE_perception : in STD_LOGIC;
           raz : in STD_LOGIC;
           num_affichage : out STD_LOGIC_VECTOR (0 to 7);
           sortie : out STD_LOGIC_VECTOR (0 to 2));
end modulo;

architecture Behavioral of modulo is
signal cmpt : std_logic_vector(2 downto 0):="000";
begin

process(CE_perception,raz)
    begin
    if(raz = '0') then
        cmpt <="000";   
    elsif rising_edge(CE_perception) then
   
                   
                    if(cmpt >= "111") then
                        cmpt <="000";
                    else
                       cmpt <= cmpt + 1;
                    end if;
               end if;
    
    end process;
    
    
Mux : process(cmpt)
     begin
     
     case cmpt is
      when "000" => 
                   num_affichage <= "11111110";
      when "001" => 
                   num_affichage <= "11111101";
      when "010" => 
                   num_affichage <= "11111011";
      when "011" => 
                   num_affichage <= "11110111";
      when "100" => 
                   num_affichage <= "11101111";
      when "101" => 
                   num_affichage <= "11011111";
      when "110" => 
                   num_affichage <= "10111111";
      when "111" => 
                   num_affichage <= "01111111";                                      
      when others => 
                   num_affichage <= "11111111";  
      
      end case;
      end process;    
    
sortie <= cmpt; 


end Behavioral;