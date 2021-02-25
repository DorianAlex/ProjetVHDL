----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2020 16:40:19
-- Design Name: 
-- Module Name: rectangle - Behavioral
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
USE ieee.numeric_std.ALL;
library work;
use work.ram.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity balle is
 Port ( xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
        clk : in std_logic;
        x_balle, y_balle : in std_logic_vector(10 downto 0); -- coordonnée gauche du rectangle
        dedans : out std_logic --1 si le pixel est dans le rectangle 0 sinon;
  );
end balle;

architecture Behavioral of balle is
signal cmpt : std_logic_vector(7 downto 0):="00000000";
begin
process(xpos)
begin 
    if(ypos < "0000000011")then 
        cmpt <= "00000000";
    end if;
   if(( to_integer(unsigned(xpos)) > to_integer(signed(x_balle))) and (to_integer(unsigned(xpos)) < (to_integer(signed(x_balle)) + 16)) and (to_integer(unsigned(ypos)) > to_integer(signed(y_balle))) and (to_integer(unsigned(ypos)) < (to_integer(signed(y_balle) + 16)))) then
--        dedans <= boule( to_integer( unsigned(xpos) - unsigned(x_balle(9 downto 0))  + (unsigned(ypos) - unsigned(y_balle(9 downto 0)))*15)); --to_integer(unsigned(x_balle(9 downto 0)) - unsigned(xpos) + (unsigned(y_balle(9 downto 0))- unsigned(ypos))*15)
--        cmpt <= std_logic_vector(unsigned(cmpt)+1); -- TO_INTEGER(unsigned(cmpt)  
        dedans <= '1';
        
--          if(cmpt > "11011111") then
--              cmpt <= "00000000";
--         end if;
    else
        dedans <= '0';
    end if;
 end process;   
  




end Behavioral;
