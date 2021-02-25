----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 15:13:14
-- Design Name: 
-- Module Name: affichage_grille - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity affichage_grille is
 Port (  xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
         grille : in std_logic_vector(39 downto 0);
         in_grille : out std_logic);
end affichage_grille;

architecture Behavioral of affichage_grille is

begin
    
    process(xpos,ypos)
        begin
        in_grille <= '1';
        for j in 0 to 4 loop
            for i in 0 to 7 loop
                if(unsigned (xpos) > (i*70)+40 and unsigned (xpos) < (i+1)*70+40 and unsigned(ypos) > j*30+60 and unsigned(ypos) < (j+1)*30+60 and grille(i+(j*8)) = '1') then 
                    in_grille <='0';
                end if;
             end loop;
         end loop;
     end process;  
end Behavioral;
