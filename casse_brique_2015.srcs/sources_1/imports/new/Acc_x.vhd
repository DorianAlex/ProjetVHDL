----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2020 15:35:26
-- Design Name: 
-- Module Name: Acc_x - Behavioral
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

entity Acc_x is
 Port ( SYSCLK     : in STD_LOGIC; -- System Clock
        RESET      : in STD_LOGIC;

   -- Accelerometer data signals
   ACCEL_Y    : out STD_LOGIC_VECTOR (11 downto 0);
   --SPI Interface Signals
   SCLK       : out STD_LOGIC;
   MOSI       : out STD_LOGIC;
   MISO       : in STD_LOGIC;
   SS         : out STD_LOGIC
);
end Acc_x;

architecture Behavioral of Acc_x is
signal reset_inverse : std_logic; 
component ADXL362Ctrl is 
generic 
(
   SYSCLK_FREQUENCY_HZ : integer := 100000000;
   SCLK_FREQUENCY_HZ   : integer := 1000000;
   NUM_READS_AVG       : integer := 16;
   UPDATE_FREQUENCY_HZ : integer := 1000
);
port
(
   SYSCLK     : in STD_LOGIC; -- System Clock
   RESET      : in STD_LOGIC;

   -- Accelerometer data signals
   ACCEL_X    : out STD_LOGIC_VECTOR (11 downto 0);
   ACCEL_Y    : out STD_LOGIC_VECTOR (11 downto 0);
   ACCEL_Z    : out STD_LOGIC_VECTOR (11 downto 0);
   ACCEL_TMP  : out STD_LOGIC_VECTOR (11 downto 0);
   Data_Ready : out STD_LOGIC;

   --SPI Interface Signals
   SCLK       : out STD_LOGIC;
   MOSI       : out STD_LOGIC;
   MISO       : in STD_LOGIC;
   SS         : out STD_LOGIC
);

end component;


signal Data_Ready : std_logic;
signal ACCEL_X,ACCEL_Z,ACCEL_TMP : std_logic_vector(11 downto 0);
begin
inst1 : ADXL362Ctrl
port map(  SYSCLK => SYSCLK,  
            RESET  => reset_inverse,
            SCLK  => SCLK,
            MOSI  => MOSI,
            MISO  => MISO,
            SS    => SS,
            ACCEL_X => ACCEL_X,
            ACCEL_Y => ACCEL_Y,
            ACCEL_Z => ACCEL_Z,
            ACCEL_TMP => ACCEL_TMP,
            Data_Ready => Data_Ready);
            
        
reset_inverse <= not(reset);

end Behavioral;
