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
use ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity roshambo_logic is
port (clock : in std_logic;
      computer_score_out : out std_logic_vector (6 downto 0);
      player_score_out : out std_logic_vector (6 downto 0);
      player_select_out : out std_logic_vector (6 downto 0);
      computer_select_out : out std_logic_vector (6 downto 0); 
      btn_l, btn_r, btn_c : in std_logic);
end roshambo_logic;


architecture Behavioral of roshambo_logic is

component decoder 
  Port (RPS_in : in integer;
        RPS_out : out std_logic_vector (6 downto 0);
        digit_in : in integer;
        digit_out : out std_logic_vector (6 downto 0));
end component;

signal computer_score : integer;
signal player_score : integer;
signal player_select : integer;
signal computer_select : integer; 
signal choice : std_logic;
signal RPS_in_p : integer := 1; -- selection of rock paper or scissors
signal digit_in_p : integer; -- binary counter from 0 to 9
signal RPS_in_c : integer := 1; -- selection of rock paper or scissors
signal digit_in_c : integer; -- binary counter from 0 to 9


begin
U6: decoder port map(RPS_in => RPS_in_p, RPS_out => player_select_out, digit_in => digit_in_p, digit_out => player_score_out);
U7: decoder port map(RPS_in => RPS_in_c, RPS_out => computer_select_out, digit_in => digit_in_c, digit_out => computer_score_out);

digit_in_p <= player_score;
digit_in_c <= computer_score;

roshambo: process(clock, btn_r, btn_l, btn_c) -- checks roshambo logic once per clock cycle if 
  --variable player_temp, computer_temp : integer := -1;
  variable state : std_logic_vector (2 downto 0) := "000";
  variable count : std_logic_vector (2 downto 0) := "000";
begin
  if rising_edge(clock) then
  count := count + 1;
    case state is
    when "000" => -- reset state, holds everthing constant for the first few milliseconds so bouncing doesn't increment anything
        player_score <= 0;
        computer_score <= 0;
        if count =  "111" then state := "001";
        else state := "XXX";
        end if;
    when "001" => -- first state, stays here if no buttons are pressed
        if btn_r = '1' or btn_l = '1' or btn_c = '1' then
        --if player_select = 0 or player_select = 1 or player_select = 2 then
          state := "011";
        else state := "001";
        end if;
    when "011" => -- this state just waits an additional clock cycle before running the scoring logic so that the scoring and
                    --and selection appear synchronous
        state := "111";
    when "111" => -- second state, entered after a button is pressed and the player makes a choice 
            if player_select - computer_select = 0 then -- tie game both scores increased
                player_score <= player_score + 1;
                computer_score <= computer_score + 1;
            elsif (((player_select - computer_select) + 3) mod 3) = 1 then -- if this expression is true the player wins
                player_score <= player_score + 1;
            else computer_score <= computer_score +1; -- otherwise the computer wins
            end if;
            --updates scores
            if player_score = 9 then -- if one player gets to 9 then both scores are reset 
            player_score <= 0;
            computer_score <= 0;
            end if;
            if computer_score = 9 then 
            computer_score <= 0;
            player_score <= 0;
            end if;
       state := "100";
    when "100" =>
       if player_select = -1 then -- if all three buttons go low, state is switched, so score is only incremented once
        state := "001";
       end if;
    when others =>
      state := "XXX";
    end case;
    
end if;    
-- updates scores


end process;

-- checks button presses and associates them with the corresponding rock, paper
-- scissors state, also sets or clears the choice signal, which sets a new game
-- starting.
kicked: process(clock, btn_r, btn_l, btn_c)
begin  
if rising_edge(clock) then
    if btn_r = '0' and btn_l = '0' and btn_c = '0' then
        choice <= '0';
        player_select <= -1;
        RPS_in_p <= -1;
    elsif btn_r = '1' and btn_l = '0' and btn_c = '0' then
        player_select <= 2;
        computer_select <= RPS_in_c;
        RPS_in_p <= 2;
        choice <= '1';
    elsif btn_l = '1' and btn_r = '0' and btn_c = '0' then
        player_select <= 0;
        computer_select <= RPS_in_c;
        RPS_in_p <= 0;
        choice <= '1';
    elsif btn_c <= '1' and btn_l = '0' and btn_r = '0' then
        player_select <= 1;
        computer_select <= RPS_in_c;
        RPS_in_p <= 1;
        choice <= '1';
    else
      choice <= 'X';
      player_select <= -1;
      RPS_in_p <= 3;
    end if;
end if;
end process;



-- When choice is low the computer's rock, paper, scissors choice spins. When
-- choice goes high, the computers selection is frozen and th players selection
-- is shown. The score is also passed to the decoder each cycle.
roshambo_rotate: process(choice, clock)

    begin

    if rising_edge(clock) then
        if choice = '0' then -- flag check to make sure a button hasn't been pressed
         if RPS_in_c = 2 then
            RPS_in_c <= 0;
         else
            RPS_in_c <= RPS_in_c + 1;
         end if;
        elsif choice = '1' then
        -- stops rotating, i.e. nothing
        end if;
    end if;
    end process;

end Behavioral;
