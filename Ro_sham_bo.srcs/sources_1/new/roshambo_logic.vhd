----------------------------------------------------------------------------------
-- Engineer: Aaron Crump
-- Class: EGR 436
--  
-- Create Date: 02/09/2017 08:43:12 PM
-- Design Name: 
-- Module Name: roshambo_logic - Behavioral
-- Project Name: Roshambo 
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
port (clock : in std_logic;
      player_select : in integer;
      computer_select : in integer;
      computer_score : out integer;
      player_score : out integer);
end roshambo_logic;

architecture Behavioral of roshambo_logic is
begin
roshambo: process(clock) -- checks roshambo logic once per clock cycle if 
  variable player_temp, computer_temp : integer := -1;
  variable state : std_logic_vector (1 downto 0) := "00";
begin
  if rising_edge(clock) then
  
    case state is
      when "00" =>
        if player_select = 0 or player_select = 1 or player_select = 2 then
          state := "01";
        else state := "00";
        end if;
    when "01" =>
            if player_select - computer_select = 0 then
                player_temp := player_temp + 1;
                computer_temp := computer_temp + 1;
                computer_score <= computer_temp;
                player_score <= player_temp;
            elsif (((player_select - computer_select) + 3) mod 3) = 1 then
                player_temp := player_temp + 1;
                player_score <= player_temp;
            else computer_temp := computer_temp +1;
                computer_score <= computer_temp;
            end if;
            --update scores
            if player_temp > 9 then player_temp := 0;
            end if;
            if computer_temp > 9 then computer_temp := 0;
            end if;
       state := "10";
    when "10" =>
       if player_select = -1 then
        state := "00";
       end if;
    when others =>
      state := "XX";
    end case;
end if;    
-- updates scores


end process;
end Behavioral;
