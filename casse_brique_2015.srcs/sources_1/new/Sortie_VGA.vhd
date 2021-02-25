----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2021 17:26:29
-- Design Name: 
-- Module Name: Sortie_VGA - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sortie_VGA is
 Port (
 in_rectangle, in_balle, in_grille, in_lettre,visible: in std_logic;
 fin : in std_logic_vector(1 downto 0);
 red,green,blue: in std_logic;		
 red_o,green_o,blue_o: out std_logic	
  );
end Sortie_VGA;

architecture Behavioral of Sortie_VGA is

begin
red_o <= red and visible and  ( ( (not(in_rectangle) or in_balle or not(in_grille))and not(fin(1))) or( not(in_lettre) and fin(1)  ) )  ;   
green_o <= green and visible and  ( ( (not(in_rectangle) or in_balle or not(in_grille))and not(fin(1))) or( not(in_lettre) and fin(1)  ) )  ;   
blue_o <= blue and visible and  ( ( (not(in_rectangle) or in_balle or not(in_grille))and not(fin(1))) or( not(in_lettre) and fin(1)  ) )  ;   

end Behavioral;
