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

entity deplacement_balle is
   Port (  clk,reset : in std_logic;
           clk200 : in std_logic;
           en : in std_logic;
           xpos,ypos : in std_logic_vector(9 downto 0);
           px,py : in std_logic_vector(1 downto 0); --(pente en x // pente en y
           x_balle_out,y_balle_out : out std_logic_vector(10 downto 0);
           in_balle : out std_logic
   );
end deplacement_balle;

architecture Behavioral of deplacement_balle is

component balle
 Port ( xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
        clk : in std_logic;
        x_balle, y_balle : in std_logic_vector(10 downto 0); -- coordonn�e gauche du rectangle
        dedans : out std_logic --1 si le pixel est dans le rectangle 0 sinon;
  );
end component;


signal flag : std_logic:= '0';
signal x_out,y_out : std_logic_vector(10 downto 0):="00000000000";
signal x_balle : std_logic_vector(10 downto 0):="00100111001";
signal  y_balle : std_logic_vector(10 downto 0):="00110101000";
begin

inst1: balle
        port map(
        xpos => xpos,
        ypos => ypos,
        clk => clk,
        x_balle => x_balle,
        y_balle => y_balle,
        dedans => in_balle);
      

    process(clk)
    begin
     if(rising_edge(clk))then
 
        if(flag ='0' and clk200 ='1' and en ='1' ) then
            if(reset ='0')then
                         y_balle <="00110101000";
                         x_balle <=     "00100111001";
             else
            flag <= '1';
            if(xpos > "0000000000" and xpos< "1010011001" and ypos > "0000000000" and ypos < "0111010001" )then 
                x_balle <= std_logic_vector(signed(x_balle) + signed(px));
                y_balle <= std_logic_vector(signed(y_balle) + signed(py));
            end if;    
         end if;
         end if;
         if(clk200 = '0') then 
            flag <= '0';
         end if;
      end if;
     end process;
 

        
x_balle_out <= x_balle;
y_balle_out <= y_balle;
end Behavioral;
