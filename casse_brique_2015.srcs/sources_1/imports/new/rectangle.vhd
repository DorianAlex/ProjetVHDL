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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rectangle is
generic
(
   y_rectangle     : integer := 440 -- coordonnée haut du rectangle
);
 Port ( xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
        clk : in std_logic;
        x_rectangle : in std_logic_vector(9 downto 0); -- coordonnée gauche du rectangle
        dedans : out std_logic --1 si le pixel est dans le rectangle 0 sinon;
  );
end rectangle;

architecture Behavioral of rectangle is
begin
process(clk)
begin 
if rising_edge(clk) then
   if(( to_integer(unsigned(xpos)) > to_integer(unsigned(x_rectangle))) and (to_integer(unsigned(xpos)) < (to_integer(unsigned(x_rectangle)) + 100)) and (to_integer(unsigned(ypos)) > y_rectangle) and (to_integer(unsigned(ypos)) < (y_rectangle + 20)) ) then
     --if(xpos > "0110010000") then
        dedans <= '0';
    else
        dedans <= '1';
    end if;
 end if;
 end process;   
  




end Behavioral;
