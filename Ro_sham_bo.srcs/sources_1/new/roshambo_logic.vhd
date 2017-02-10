----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2017 08:43:12 PM
-- Design Name: 
-- Module Name: roshambo_logic - Behavioral
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

entity roshambo_logic is
port (
      player_select : in integer;
      computer_select : in integer;
      computer_score : out integer;
      player_score : out integer);
end roshambo_logic;

architecture Behavioral of roshambo_logic is
begin
roshambo: process(player_select) -- just checks button presses
variable player_temp, computer_temp : integer := 0;
begin   
            if player_select - computer_select = 0 then
                player_temp := player_temp + 1;
                computer_temp := computer_temp + 1;
            elsif (((player_select - computer_select) + 3) mod 3) = 1 then
                player_temp := player_temp + 1;
            else computer_temp := computer_temp +1;
            end if;
        
if player_temp > 9 then player_temp := 0;
end if;
if computer_temp > 9 then computer_temp := 0;
end if;    
computer_score <= computer_temp;
player_score <= player_temp;        
        
end process;
end Behavioral;