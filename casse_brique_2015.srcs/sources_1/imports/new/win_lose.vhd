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

entity win_lose is
 Port (  clk : in std_logic;
         xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
         grille : in std_logic_vector(125 downto 0);
         in_grille : out std_logic);
end win_lose;

architecture Behavioral of win_lose is

begin
    
    process(clk)
        begin
        in_grille <= '1';
        for j in 0 to 8 loop
            for i in 0 to 13 loop
                if(unsigned (xpos) > (i*40)+40 and unsigned (xpos) < (i+1)*40+40 and unsigned(ypos) > j*40+60 and unsigned(ypos) < (j+1)*40+60 and grille(i+(j*14)) = '1') then 
                    in_grille <='0';
                end if;
             end loop;
         end loop;
     end process;  
end Behavioral;
