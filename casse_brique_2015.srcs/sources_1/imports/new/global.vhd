----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2021 20:13:24
-- Design Name: 
-- Module Name: global - Behavioral
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

entity global is
Port (
        clk,reset: in std_logic;							-- Horloge, Reset Asynchrone
		red_o,green_o,blue_o: out std_logic;						-- Affichage Couleur vers Ecran VGA
		hsync,vsync: out std_logic
		);				-- Synchro Ligne (H) et Trame (V)
end global;

architecture Behavioral of global is

component mot 
port(clk : in std_logic;
etat : in std_logic;
 grille : out std_logic_vector(125 downto 0)
 
  );
  end component;

component ClkDiv 
    Port ( clk100,reset : in  STD_LOGIC;	-- Horloge 100 Mhz et Reset Asynchrone
           clk200 : out STD_logic; -- horloge actualisation element de jeu
           clk250 : out std_logic;
           clk25 : out  STD_LOGIC);			-- Horloge 25 MHz
end component;



component VGA 
port (
		clk25,reset: in std_logic;							-- Horloge, Reset Asynchrone
		r,g,b: in std_logic;									-- Couleur Envoyee par le Controleur de Jeu
		red,green,blue: out std_logic;						-- Affichage Couleur vers Ecran VGA
		hsync,vsync: out std_logic;						-- Synchro Ligne (H) et Trame (V)
		visible: out std_logic;								-- Partie Visible de l'Image
		endframe: out std_logic;							-- Dernier Pixel Visible d'une Trame
		xpos,ypos: out std_logic_vector(9 downto 0)	-- Coordonnees du Pixel Courant
	);
end component;

 component win_lose
  Port (  clk : in std_logic;
         xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
         grille : in std_logic_vector(125 downto 0);
         in_grille : out std_logic);
 end component;

signal visible: std_logic;
signal red,green,blue : std_logic;
signal endframe : std_logic;
signal clk25,clk200,clk250 : std_logic; -- horloge à respectivement 25MHz et 200Hz
signal in_rectangle, in_balle, in_grille: std_logic;
signal grille : std_logic_vector(125 downto 0); --:= (others => '1');
signal xpos,ypos: std_logic_vector(9 downto 0);
signal x_barre : std_logic_vector(9 downto 0):="0001100100";
signal ACCEL_Y  : STD_LOGIC_VECTOR (11 downto 0);
signal CE_perception, CE_affichage : STD_logic;
signal sortie_compt : std_logic_vector(3 downto 0);
signal sortie_mod : std_logic_vector(2 downto 0);
signal sortie_mux : std_logic_vector(3 downto 0);
signal nombre_uni, nombre_diz, nombre_min, nombre_min_diz : std_logic_vector(3 downto 0);
signal nombre_unib, nombre_dizb : std_logic_vector(3 downto 0);
signal E0,E1,E2,E3,E4,E5,E6,E7 : std_logic_vector(3 downto 0);

begin

inst1 : ClkDiv 
    port map( clk100 => clk,
              reset => reset,
              clk200 => clk200,
              clk250 => clk250,
              clk25 => clk25);
              
              inst2 : VGA
                  port map(
                           clk25 => clk25,
                           reset => reset,
                           r => '1',
                           g => '1',
                           b => '1',
                           red => red,
                           green => green,
                           blue => blue,
                           hsync => hsync,
                           vsync => vsync,
                           visible => visible,
                           endframe => endframe,
                           xpos => xpos,
                           ypos => ypos);
                           
 inst3 : win_lose
                                   port map(
                                       clk => clk,
                                       xpos => xpos,
                                       ypos => ypos,
                                       grille => grille,
                                       in_grille => in_grille);
                                       
inst4 : mot
            port map( clk => clk,
                        etat => '0',
                        grille => grille);                                      
                           
red_o <= red and visible and not(in_grille);   
green_o <= green and visible and not(in_grille);  
blue_o <= blue and visible and  not(in_grille); 


end Behavioral;
