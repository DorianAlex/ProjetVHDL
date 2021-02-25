library IEEE,work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity rebond is
    port (
       clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       clk200 : in STD_LOGIC;
       px_out,py_out : out std_logic_vector(1 downto 0);
       perdu : out std_logic;
       xpos,ypos : in std_logic_vector(9 downto 0);
       clk250 : in std_logic;
       en : in std_logic;
       xbarre : in std_logic_vector(9 downto 0); -- position de la barre 
       grille_out :  out std_logic_vector(39 downto 0);
       in_balle : out std_logic
       
    );
end rebond;

architecture Behavioral of rebond is 

--component deplacement_balle 
--   Port (  clk,reset : in std_logic;
--           clk200 : in std_logic;
--           en : in std_logic;
--           xpos,ypos : in std_logic_vector(9 downto 0);
--           px,py : in std_logic_vector(1 downto 0); --(pente en x // pente en y
--           x_balle_out,y_balle_out : out std_logic_vector(10 downto 0);
--           in_balle : out std_logic
--   );
--end component;

component balle
 Port ( xpos,ypos : in std_logic_vector(9 downto 0); -- position pixel
        clk : in std_logic;
        x_balle, y_balle : in std_logic_vector(10 downto 0); -- coordonn�e gauche du rectangle
        dedans : out std_logic --1 si le pixel est dans le rectangle 0 sinon;
  );
end component;

signal px : std_logic_vector(1 downto 0):="11";
signal py : std_logic_vector(1 downto 0):="11";
signal x_balle : std_logic_vector(10 downto 0);
signal grille :  std_logic_vector(39 downto 0):="1111111111111111111111111111111111111111";
signal  y_balle : std_logic_vector(10 downto 0);
signal flag, flag1,flag2 : std_logic:= '0';
begin

--inst1 : deplacement_balle 
--    port map (
--            clk => clk,
--            clk200 => clk200,
--            px => px,
--            py => py,
--            xpos => xpos,
--            ypos => ypos,
--            en => en,
--            x_balle_out => x_balle,
--            y_balle_out => y_balle,
--            reset => reset,
--            in_balle => in_balle
--            );

inst2: balle
        port map(
        xpos => xpos,
        ypos => ypos,
        clk => clk,
        x_balle => x_balle,
        y_balle => y_balle,
        dedans => in_balle);

process(clk)
begin
            if rising_edge(clk) then 
                if(reset = '0')then
                    px <= "11";
                    py <= "11"; 
                    grille <=   "1111111111111111111111111111111111111111";--"1111111111111111111111111111111111111111";   "0000000000000000000000000000000000000001"
                   y_balle <="00110101000";
                     x_balle <=     "00100111101";  
                     perdu <= '0';
                     flag2 <= '1';
                else
               
                    if(flag ='0' and clk200 ='1' and en = '1') then
    
                        flag <= '1';
                        flag1<= '1';
                            
                         if(xpos > "0000000000" and xpos< "1010011001" and ypos > "0000000000" and ypos < "0111010001" )then 
                            x_balle <= std_logic_vector(signed(x_balle) + signed(px));
                            y_balle <= std_logic_vector(signed(y_balle) + signed(py));
                         end if; 
                            
                      for j in 0 to 4 loop
                         for i in 0 to 7 loop
                             if(signed(x_balle)+15 > (i*70)+40   and signed(x_balle) < (i+1)*70+40 and signed(y_balle)+15 > j*30+60 and signed(y_balle) < (j+1)*30+60 and grille(i+(j*8)) = '1') then 
                               if(signed(x_balle)+15 > (i*72)+40 and signed(x_balle) < (i+1)*68+40 and signed(y_balle)+15 > j*30+60 and signed(y_balle) < (j+1)*30+60 and grille(i+(j*8)) = '1') then 
                                if(flag2 = '1') then 
                                py(1) <= not(py(1));
                                flag2 <='0';
                                end if;
                               else
                                 if(flag2 = '1') then 
                                px(1) <= not(px(1));
                                flag2 <='0';
                                end if;
                               end if;
                               grille(i+(j*8)) <= '0';
                               flag1 <= '0';
                             end if;     
                         end loop;
                     end loop;
                --rebond contre le mur droit
                    if signed(x_balle) > 625 then
                        if(flag2 = '1') then
                            px(1) <= not(px(1));
                            px(0) <= px(0);
                            flag2 <='0';
                        end if;    
                          

                --rebond contre le mur gauche
                    elsif signed(x_balle) < 1 then 
                        if(flag2 = '1') then
                        px(1) <= not(px(1));
                        px(0) <= px(0);
                        flag2 <='0';
                        end if; 
                       
                        
                    
                    --rebond contre le mur haut
                    elsif signed(y_balle) < 1 then 
                        if(flag2 = '1') then
                        py(1) <= not(py(1));
                        py(0) <= py(0);
                        flag2 <='0';  
                         end if; 
                       
                       
                    
                   --rebond contre le mur bas
                    elsif signed(y_balle) > 465 then 
                        if(flag2 = '1') then
                     perdu <= '1';
                     end if; 
                     
    --                            --rebond contre le centre de la barre
                    elsif ((signed(y_balle) > 433) and (x_balle(9 downto 0) > std_logic_vector(unsigned(xbarre)+20)) and (x_balle(9 downto 0) < std_logic_vector(unsigned(xbarre)+80 ))) then --+ 20  + 80
                        if(flag2 = '1') then
                        py(1) <= not(py(1));
                        py(0) <= py(0);
                        flag2 <='0';
                         end if; 
                        
    
                                --rebond contre la partie gauche de la barre
                     elsif ((signed(y_balle) > 433) and (x_balle(9 downto 0) > std_logic_vector(unsigned(xbarre))) and (x_balle(9 downto 0) < std_logic_vector(unsigned(xbarre)+19 ))) then
                       if(flag2 = '1') then
                        py(1) <= not(py(1));
                        py(0) <= py(0);
                        px(1) <= '1';
                        px(0) <= '1';
                         flag2 <='0';
                         end if; 
                       
    
    --                            --rebond contre la partie droite de la barre
                    elsif ((signed(y_balle) > 433) and (x_balle(9 downto 0) > std_logic_vector(unsigned(xbarre)+81)) and (x_balle(9 downto 0) < std_logic_vector(unsigned(xbarre)+100 ))) then
                       if(flag2 = '1') then
                        py(1) <= not(py(1));
                        py(0) <= py(0);
                        px(1) <= '0';
                        px(0) <= '1';
                        flag2 <='0';
                        end if; 
                    elsif (flag1 = '1') then
                        flag2 <= '1';
                         
                    end if;
              end if;
            end if;
         if(clk200 = '0') then 
            flag <= '0';
         end if;
        end if; 
    end process;

px_out <= px;
py_out <= py;
grille_out <= grille;
end Behavioral;        