----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2021 21:15:13
-- Design Name: 
-- Module Name: mot - Behavioral
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

entity mot is
 Port (clk : in std_logic;
 etat : in std_logic;
 grille : out std_logic_vector(125 downto 0)
 
  );
end mot;

architecture Behavioral of mot is

begin

    process(clk)
    
    begin
    
    if (etat = '0') then
        grille <= ("000000000000000000000000000010001010111110110010101010101010101010101010011000101010100010101010100000000000000000000000000000");
   else
        grille <= "000000000000000000000000000011101110111011001010001010010110111010100100100010101001111011101110010000000000000000000000000000";
   end if;
    
    
       end process;


end Behavioral;
