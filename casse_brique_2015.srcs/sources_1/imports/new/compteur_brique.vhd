library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compteur_brique is port(
    clk : in std_logic;
    reset : in std_logic;
    grille : in std_logic_vector(39 downto 0);
    cpt_unitb : out std_logic_vector(3 downto 0);
    gagner : out std_logic;
    cpt_dizb : out std_logic_vector(3 downto 0)

    );
end compteur_brique;

architecture rtl of compteur_brique is



begin



process(clk,reset)



variable a, b, e : integer;
variable x : unsigned (5 downto 0);
variable c : unsigned (39 downto 0);
variable d : std_logic_vector (5 downto 0);

begin

if(reset = '0') then
    gagner <= '0';
else
  if((b + e) = 0) then
        gagner <= '1';
     end if;
end if;
c := unsigned(grille);

x:= (others => '0');
for i in 0 to 39 loop
	x := x + ('0' & grille(i));
end loop;

d := std_logic_vector(x);

a := to_integer(unsigned(d));

b := a mod 10;
e := (a-b)/10;



cpt_unitb <=  std_logic_vector(to_unsigned(b, 4));
cpt_dizb <=  std_logic_vector(to_unsigned(e, 4));
  

--cpt_dizb <= d(0) & d(1) & d(2) & d(3);



--nombre_temp := to_integer(x);
--dizaine_temp := 0;

--while nombre_temp > 9 loop
--nombre_temp := nombre_temp - 10;
--dizaine_temp := dizaine_temp + 1;
--end loop;

--cpt_unitb <= std_logic_vector (to_unsigned(nombre_temp, 4));
--cpt_dizb <= std_logic_vector (to_unsigned(dizaine_temp, 4));
end process;


 

 end rtl;
