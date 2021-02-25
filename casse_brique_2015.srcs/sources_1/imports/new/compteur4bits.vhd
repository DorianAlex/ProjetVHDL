library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity compteur4bits is port(
    clk : in std_logic;
    reset : in std_logic;
    gagner,en : in std_logic;
    cpt_unit : out std_logic_vector(3 downto 0);
    cpt_diz : out std_logic_vector(3 downto 0);
    cpt_min : out std_logic_vector(3 downto 0);
    cpt_min_diz : out std_logic_vector(3 downto 0)
    );
end compteur4bits;

architecture rtl of compteur4bits is

signal cpt1 : std_logic_vector(3 downto 0):="0000";
signal cpt2 : std_logic_vector(3 downto 0):="0000";
signal cpt3 : std_logic_vector(3 downto 0):="0000";
signal cpt4 : std_logic_vector(3 downto 0):="0000";

    begin
        process(clk,reset)
        begin
           
          if reset ='0' then
            cpt1 <= "0000";
            cpt2 <= "0000";
            cpt3 <= "0000";
            cpt4 <= "0000";
        elsif rising_edge(clk) then
              if(gagner = '0' and en = '1') then
                if cpt4 < 6 then
                    if cpt3 < 9 then
                        if cpt2 < 6 then 
                            if cpt1 < 9 then
                                cpt1 <= cpt1 + 1;
                            else 
                                cpt1 <= "0000" ;
                                cpt2 <= cpt2 + 1;
                            end if;
                        else 
                                cpt1 <= "0001";
                                cpt2 <= "0000"; 
                                cpt3 <= cpt3 + 1;
                        end if;
                    else 
                           cpt1 <= "0000";
                           cpt2 <= "0000"; 
                           cpt3 <= "0000";
                           cpt4 <= cpt4 + 1;
                   end if;
                   else cpt4 <="0000";
                    end if;

               end if;
             end if;
        end process;

    cpt_unit <= cpt1;
    cpt_diz <= cpt2;
    cpt_min <= cpt3;
    cpt_min_diz <= cpt4;       

 end rtl;