----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 18:11:12
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
   Port ( 
    clk,clk200 ,reset: in std_logic;
    bouton : in std_logic;
    perdu : in std_logic;
    gagner : in std_logic; 
    en : out std_logic;
    test : out std_logic;
    fin : out std_logic_vector(1 downto 0) -- "11" == perdu // "10" == gagné
   );
end FSM;

architecture Behavioral of FSM is

 type etats is (etat_debut, etat_partie, etat_termine);
 signal  Etat_Present, Etat_Futur : etats;

begin


 
 registre : process(clk)
 begin 
     if rising_edge(clk) then
         if(RESET ='0') then
             Etat_Present <= Etat_debut;
         else
                  Etat_Present <= Etat_Futur;
     end if;
     end if;
 end process;
 
 sortie : process( Etat_present, bouton,perdu,gagner)
 begin
     Case Etat_Present is 
         when etat_debut =>  en <= '0';
                            fin <= "00";
                            test <= '0';
                            IF bouton = '1' THEN
                                                Etat_Futur <= etat_partie;
                                            Else 
                                               Etat_Futur <= Etat_debut;
                                            end IF;
                          
         when etat_partie =>  en <= '1';
                            test <= '1';
                                IF (perdu = '1') THEN
                                
                             Etat_Futur <= etat_termine;
                         Elsif(gagner = '1') then
                            Etat_Futur <= etat_termine;
                         else
                             Etat_Futur <=etat_partie;
                         end IF;
                   
            when etat_termine => en <= '0';
                                 IF (gagner = '1') THEN
                                  fin <= "10";
                                 end if;
                                if( perdu ='1')then
                                    fin <= "11";
                                end IF;
                                Etat_Futur <= etat_termine;   
                             
           -- when others =>Etat_futur <= etat_debut ;
          
    end case;
 end process; 
 end Behavioral;
 