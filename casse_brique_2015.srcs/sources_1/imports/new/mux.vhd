----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2020 14:32:18
-- Design Name: 
-- Module Name: mux8 - Behavioral
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

entity mux is
    Port ( commande : in STD_LOGIC_VECTOR (0 to 2);
           E0 : in STD_LOGIC_VECTOR(3 downto 0);
           E1 : in STD_LOGIC_VECTOR(3 downto 0);
           E2 : in STD_LOGIC_VECTOR(3 downto 0);
           E3 : in STD_LOGIC_VECTOR(3 downto 0);
           E4 : in STD_LOGIC_VECTOR(3 downto 0);
           E5 : in STD_LOGIC_VECTOR(3 downto 0);
           E6 : in STD_LOGIC_VECTOR(3 downto 0);
           E7 : in STD_LOGIC_VECTOR(3 downto 0);
           sortie : out STD_LOGIC_VECTOR(3 downto 0));
end mux;

architecture Behavioral of mux is



begin
 p_CASE : process (commande)
 begin
 case commande is
 
  when "000" =>   sortie <=  E0;
  when "001" =>   sortie <=  E1;
  when "010" =>   sortie <=  E2;
  when "011" =>   sortie <=  E3;
  when "100" =>   sortie <=  E4;
  when "101" =>   sortie <=  E5;
  when "110" =>   sortie <=  E6;
  when "111" =>   sortie <=  E7;
  
end case;

end process;

end Behavioral;