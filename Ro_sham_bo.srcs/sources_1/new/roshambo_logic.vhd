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
      computer_score : inout integer;
      player_score : inout integer);
end roshambo_logic;

architecture Behavioral of roshambo_logic is
begin
roshambo: process(clock, player_score, computer_score) -- checks roshambo logic once per clock cycle if 
  --variable player_temp, computer_temp : integer := -1;
  variable state : std_logic_vector (1 downto 0) := "00";
begin
  if rising_edge(clock) then
  
    case state is
      when "00" => -- first state, stays here if no buttons are pressed
        if player_select = 0 or player_select = 1 or player_select = 2 then
          state := "01";
        else state := "00";
        end if;
    when "01" => -- second state, entered after a button is pressed and the player makes a choice 
            if player_select - computer_select = 0 then -- tie game both scores increased
                player_score <= player_score + 1;
                computer_score <= computer_score + 1;
--                player_temp := player_temp + 1;
--                computer_temp := computer_temp + 1;
--                computer_score <= computer_temp;
--                player_score <= player_temp;
            elsif (((player_select - computer_select) + 3) mod 3) = 1 then -- if this expression is true the player wins
                player_score <= player_score + 1;
--                player_temp := player_temp + 1;
--                player_score <= player_temp;
            else computer_score <= computer_score +1; -- otherwise the computer wins
                --computer_score <= computer_temp;
            end if;
            --update scores
            if player_score = 9 then -- if one player gets to 9 then both scores are reset 
            player_score <= 0;
            computer_score <= 0;
            end if;
            if computer_score = 9 then 
            computer_score <= 0;
            player_score <= 0;
            end if;
       state := "10";
    when "10" =>
       if player_select = -1 then -- if all three buttons go low, state is switched, so score is only incremented once
        state := "00";
       end if;
    when others =>
      state := "XX";
    end case;
end if;    
-- updates scores


end process;
end Behavioral;
