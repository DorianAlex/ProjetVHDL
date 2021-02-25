----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2021 17:37:54
-- Design Name: 
-- Module Name: Global - Behavioral
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

entity Global is
 Port ( clk,reset: in std_logic;							-- Horloge, Reset Asynchrone
        bouton : in std_logic;
		red_o,green_o,blue_o: out std_logic;						-- Affichage Couleur vers Ecran VGA
		hsync,vsync: out std_logic;						-- Synchro Ligne (H) et Trame (V)
		SCLK       : out STD_LOGIC;
        MOSI       : out STD_LOGIC;
        MISO       : in STD_LOGIC;
        SS         : out STD_LOGIC;
        AN : out STD_LOGIC_VECTOR (0 to 7);
        sept_segment : out STD_LOGIC_VECTOR (7 downto 0)
		);
end Global;

architecture Behavioral of Global is

component mot 
port(clk : in std_logic;
etat : in std_logic;
 grille : out std_logic_vector(125 downto 0)
 
  );
  end component;
  
   component win_lose
  Port (  clk : in std_logic;
         xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
         grille : in std_logic_vector(125 downto 0);
         in_grille : out std_logic);
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
		hsync,vsync: out std_logic;						-- Synchro Ligne (H) et Trame (V)
		visible: out std_logic;								-- Partie Visible de l'Image
		endframe: out std_logic;							-- Dernier Pixel Visible d'une Trame
		xpos,ypos: out std_logic_vector(9 downto 0)	-- Coordonnees du Pixel Courant
	);
end component;

component deplacement_barre
   Port (  clk,reset : in std_logic;
           clk200 : in std_logic;
           en : in std_logic;
           xpos,ypos : in std_logic_vector(9 downto 0);
           direction : in std_logic_vector(11 downto 0); -- 11 droite // 00 gauche
           x_barre : out std_logic_vector(9 downto 0);
           in_rectangle : out std_logic
   );
end component;

component Acc_x 
Port ( SYSCLK     : in STD_LOGIC; -- System Clock
        RESET      : in STD_LOGIC;
        ACCEL_Y    : out STD_LOGIC_VECTOR (11 downto 0);
        SCLK       : out STD_LOGIC;
        MOSI       : out STD_LOGIC;
        MISO       : in STD_LOGIC;
        SS         : out STD_LOGIC
);
end component;



component rebond
    port (
       clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       clk200 : in STD_LOGIC;
       xpos,ypos : in std_logic_vector(9 downto 0);
       xbarre : in std_logic_vector(9 downto 0); -- position de la barre 
       clk250 : in std_logic;
       perdu : out std_logic;
       en : in std_logic;
       grille_out :  out std_logic_vector(39 downto 0);
       px_out,py_out : out std_logic_vector(1 downto 0);
       in_balle : out std_logic
    );
 end component;
 
 component affichage_grille
  Port (  
         xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
         grille : in std_logic_vector(39 downto 0);
         in_grille : out std_logic);
 end component;


component FSM 
    Port ( 
    clk,clk200,reset: in std_logic;
    bouton : in std_logic;
    perdu : in std_logic;
    gagner : in std_logic; 
    test : out std_logic;
    en : out std_logic;
    fin : out std_logic_vector(1 downto 0) -- "10" == perdu // "01" == gagné
   );
 end component;
 
        
 component decodeur7segments 
     port(       commande : in STD_LOGIC_VECTOR (0 to 2);
                 valeur : in std_logic_vector(3 downto 0);
                 Valeuraffichage : out std_logic_vector(7 downto 0));
 end component;
 
 component compteur4bits 
     port(        
                     clk : in std_logic;
                     reset : in std_logic;
                     gagner,en : in std_logic;
                     cpt_unit : out std_logic_vector(3 downto 0);
                     cpt_diz : out std_logic_vector(3 downto 0);
                     cpt_min : out std_logic_vector(3 downto 0);
                     cpt_min_diz : out std_logic_vector(3 downto 0));
 end component;
 
 component modulo is
     Port ( clk : in STD_LOGIC;
            CE_perception : in STD_LOGIC;
            raz : in STD_LOGIC;
            num_affichage : out STD_LOGIC_VECTOR (0 to 7);
            sortie : out STD_LOGIC_VECTOR (0 to 2));
 end component;
 
 component mux is
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
 end component;
 
  component Gestion_freq 
     port( clk : in STD_LOGIC;
       raz : in STD_LOGIC;
       CE_affichage : out STD_LOGIC;
       CE_perception : out STD_LOGIC);
 end component;
 
component compteur_brique is port(
     clk : in std_logic;
    reset : in std_logic;
    gagner : out std_logic;
     grille : in std_logic_vector(39 downto 0);
     cpt_unitb : out std_logic_vector(3 downto 0);
     cpt_dizb : out std_logic_vector(3 downto 0)
 
     );
 end component;
 
 component Sortie_VGA is
  Port (
 in_rectangle, in_balle, in_grille, in_lettre,visible: in std_logic;
 fin : in std_logic_vector(1 downto 0);
 red,green,blue: in std_logic;		
 red_o,green_o,blue_o: out std_logic	
  );
  end component;

signal visible: std_logic;
signal red,green,blue : std_logic;
signal endframe : std_logic;
signal clk25,clk200,clk250 : std_logic; -- horloge à respectivement 25MHz et 200Hz
signal in_rectangle, in_balle, in_grille, in_lettre: std_logic;
signal grille : std_logic_vector(39 downto 0):="1111111111111111111111111111111111111111";
signal xpos,ypos: std_logic_vector(9 downto 0);
signal x_barre : std_logic_vector(9 downto 0):="0001100100";
signal ACCEL_Y  : STD_LOGIC_VECTOR (11 downto 0);
signal perdu, en,gagner : std_logic;
signal fin : std_logic_vector (1 downto 0);
signal letre : std_logic_vector(125 downto 0); --:= (others => '1');
signal sortie_compt : std_logic_vector(3 downto 0);
signal sortie_mod : std_logic_vector(2 downto 0);
signal sortie_mux : std_logic_vector(3 downto 0);
signal nombre_uni, nombre_diz, nombre_min, nombre_min_diz : std_logic_vector(3 downto 0);
signal nombre_unib, nombre_dizb : std_logic_vector(3 downto 0);
signal E0,E1,E2,E3,E4,E5,E6,E7 : std_logic_vector(3 downto 0);
signal CE_perception, CE_affichage : STD_logic;
signal px,py      : std_logic_vector(1 downto 0);




begin

inst16 : Sortie_VGA port map(
                in_rectangle => in_rectangle, 
                in_balle => in_balle, 
                in_grille => in_grille, 
                in_lettre => in_lettre,
                visible => visible,
                fin => fin,
                red => '1',
                green => '1',
                blue => '1',
                red_o => red_o,
                green_o => green_o,
                blue_o => blue_o);
                
                

inst15 : Gestion_freq port map(
                 clk => clk,
                 raz => reset,
                 CE_perception => CE_perception,
                 CE_affichage => CE_affichage
                ); 

inst14 : compteur_brique
        port map(clk => CE_affichage,
                 reset => reset,
                 grille => grille,
                 gagner => gagner,
                 cpt_unitb => nombre_unib,
                 cpt_dizb => nombre_dizb
        );
        
inst13 : mux port map(
             commande => sortie_mod,
             E0 => nombre_dizb,
             E1 => nombre_unib,
             E2 => "1111",
             E3 => "1111",
             E4 => nombre_min_diz,
             E5 => nombre_min,
             E6 => nombre_diz,
             E7 => nombre_uni,
             sortie => sortie_mux
             );
             
 
 inst12 : modulo port map(
                     clk => clk,
                     CE_perception => CE_perception,
                     raz => reset,
                     num_affichage => AN,
                     sortie => sortie_mod
                     );
                         
 inst11 : compteur4bits port map(
                         clk => CE_affichage,
                         reset => reset,
                         en => en,
                         gagner => gagner,
                         cpt_unit => nombre_uni,
                         cpt_diz => nombre_diz,
                         cpt_min => nombre_min,
                         cpt_min_diz => nombre_min_diz);
                         
              
 inst10 :   decodeur7segments port map(
         commande => sortie_mod,
         valeur => sortie_mux,
         Valeuraffichage => sept_segment
         );

inst9 : FSM
        port map(
            clk => clk,
            clk200 => clk200,
            reset => reset,
            bouton => bouton,
            perdu => perdu,
            gagner => gagner,
            en => en,
            fin => fin);
            
 inst8 : win_lose
            port map(
               clk => clk,
               xpos => xpos,
               ypos => ypos,
               grille => letre,
               in_grille => in_lettre);
                                       
inst7 : mot
    port map( clk => clk,
                etat => fin(0),
                grille => letre);     


inst6 : affichage_grille
        port map(
            xpos => xpos,
            ypos => ypos,
            grille => grille,
            in_grille => in_grille);

inst5 : rebond
        port map (
                clk => clk,
                clk200 => clk200,
                clk250 => clk250,
                reset => reset,
                xpos => xpos,
                ypos => ypos,
                xbarre => x_barre,
                en => en,
                perdu => perdu,
                px_out => px,
                py_out => py,
                grille_out => grille,
                in_balle => in_balle
        );


inst4 : Acc_x 
        port map(
            SYSCLK => clk,
            RESET => reset,
            ACCEL_Y => ACCEL_Y,
            SCLK => SCLK,
            MOSI => MOSI,
            MISO => MISO,
            SS => SS);
            
inst3 : deplacement_barre 
    port map (
            clk => clk,
            reset => reset,
            en => en,
            clk200 => clk200,
            xpos => xpos,
            ypos => ypos,
            direction => ACCEL_Y,
            x_barre => x_barre,
            in_rectangle => in_rectangle
            );
            

inst2 : VGA
    port map(
             clk25 => clk25,
             reset => reset,
             hsync => hsync,
             vsync => vsync,
             visible => visible,
             endframe => endframe,
             xpos => xpos,
             ypos => ypos);
            
inst1 : ClkDiv 
    port map( clk100 => clk,
              reset => reset,
              clk200 => clk200,
              clk250 => clk250,
              clk25 => clk25);


end Behavioral;
