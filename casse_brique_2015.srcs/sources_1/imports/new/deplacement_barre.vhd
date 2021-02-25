----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2020 18:54:02
-- Design Name: 
-- Module Name: deplacement_barre - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deplacement_barre is
   Port (  clk,reset : in std_logic;
           clk200 : in std_logic;
           xpos,ypos : in std_logic_vector(9 downto 0);
           direction : in std_logic_vector(11 downto 0); -- 11 droite // 00 gauche
           en : in std_logic;
           x_barre : out std_logic_vector(9 downto 0);
           in_rectangle : out std_logic
   );
end deplacement_barre;

architecture Behavioral of deplacement_barre is

component rectangle
generic
(
   y_rectangle     : integer := 440 -- coordonn�e haut du rectangle
);
 Port ( xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
        clk : in std_logic;
        x_rectangle : in std_logic_vector(9 downto 0); -- coordonn�e gauche du rectangle
        dedans : out std_logic --1 si le pixel est dans le rectangle 0 sinon;
  );
end component;

signal flag : std_logic:= '0';
signal x_rectangle :  std_logic_vector(9 downto 0):="0100001110";

begin
inst1 : rectangle 
    generic map(
            y_rectangle => 440)
    
    port map(
            xpos => xpos,
            ypos => ypos,
            clk => clk,
            x_rectangle => x_rectangle,
            dedans => in_rectangle);

    process(clk)
    begin
        if(reset = '0') then
            x_rectangle <= "0100001110";
         else
     if(rising_edge(clk))then
        if(flag ='0' and clk200 ='1' and en = '1') then
            flag <= '1';
            if( direction(10) = '0' and direction(9) = '0' and direction(8) = '0' and direction(7) = '0' and direction(6) = '0' and direction(5) = '1' and direction(11) = '0') then
            
            elsif(direction(11) = '0' and x_rectangle > "0000001000") then 
                    if(direction(10) = '1')then 
                       x_rectangle <= std_logic_vector(unsigned(x_rectangle)-2);
                   else
                        x_rectangle <= std_logic_vector(unsigned(x_rectangle)-1);
                   end if; 
            
            elsif(direction(11) = '1' and x_rectangle < "1000011100" ) then 
                     if(direction(10) = '0')then 
                               x_rectangle <= std_logic_vector(unsigned(x_rectangle)+2);
                     else
                               x_rectangle <= std_logic_vector(unsigned(x_rectangle)+1);
                     end if;
            end if;
         end if;
        end if;
         if(clk200 = '0') then 
            flag <= '0';
         end if;
      end if;
     end process;
        
x_barre <= x_rectangle;

end Behavioral;
