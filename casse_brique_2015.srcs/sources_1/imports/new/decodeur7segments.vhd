library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decodeur7segments is
 Port ( commande : in STD_LOGIC_VECTOR (0 to 2);
        valeur : in std_logic_vector(3 downto 0);
        Valeuraffichage : out std_logic_vector(7 downto 0)
  );
end decodeur7segments;

architecture Behavioral of decodeur7segments is

begin

mux : process(valeur)
    begin
    
    if commande = "101" then 
    
    Case valeur is 
        when "0000" => Valeuraffichage <= "01000000";
        when "0001" => Valeuraffichage <= "01111001";
        when "0010" => Valeuraffichage <= "00100100";
        when "0011" => Valeuraffichage <= "00110000";
        when "0100" => Valeuraffichage <= "00011001";
        when "0101" => Valeuraffichage <= "00010010";
        when "0110" => Valeuraffichage <= "00000010";
        when "0111" => Valeuraffichage <= "01111000";
        when "1000" => Valeuraffichage <= "00000000";
        when "1001" => Valeuraffichage <= "00010000";
        when others => Valeuraffichage <= "01111111";
    end case;
    
        else 
        
         Case valeur is 
            when "0000" => Valeuraffichage <= "11000000";
            when "0001" => Valeuraffichage <= "11111001";
            when "0010" => Valeuraffichage <= "10100100";
            when "0011" => Valeuraffichage <= "10110000";
            when "0100" => Valeuraffichage <= "10011001";
            when "0101" => Valeuraffichage <= "10010010";
            when "0110" => Valeuraffichage <= "10000010";
            when "0111" => Valeuraffichage <= "11111000";
            when "1000" => Valeuraffichage <= "10000000";
            when "1001" => Valeuraffichage <= "10010000";
            when others => Valeuraffichage <= "11111111";
        end case;
        
        end if;
end process;
end Behavioral;