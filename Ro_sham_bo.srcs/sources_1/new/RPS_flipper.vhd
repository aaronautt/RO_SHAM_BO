----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2017 06:26:35 PM
-- Design Name: 
-- Module Name: RPS_flipper - Behavioral
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

entity RPS_flipper is
  Port (btn_out_r : in std_logic;
        btn_out_l : in std_logic;
        btn_out_c : in std_logic;
        clock in std );
end RPS_flipper;

architecture Behavioral of RPS_flipper is

begin
-- checks button presses and associates them with the corresponding rock, paper
-- scissors state, also sets or clears the choice signal, which sets a new game
-- starting.
kicked: process(clock_divide, btn_out_r, btn_out_l, btn_out_c)
begin  
if rising_edge(clock_divide) then
    if btn_out_r = '0' and btn_out_l = '0' and btn_out_c = '0' then
        choice <= '0';
        player_select <= -1;
    elsif btn_out_r = '1' and btn_out_l = '0' and btn_out_c = '0' then
        player_select <= 2;
        computer_select <= RPS_in_c;
        RPS_in_p <= 2;
        choice <= '1';
    elsif btn_out_l = '1' and btn_out_r = '0' and btn_out_c = '0' then
        player_select <= 0;
        computer_select <= RPS_in_c;
        RPS_in_p <= 0;
        choice <= '1';
    elsif btn_out_c <= '1' and btn_out_l = '0' and btn_out_r = '0' then
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
roshambo_rotate: process(choice, slow_clk)

    begin

    if rising_edge(slow_clk) then
    digit_in_p <= player_score;
    digit_in_c <= computer_score;
    computer_score_digit <= digit_out_c;
    player_score_digit <= digit_out_p;
        if choice = '0' then -- flag check to make sure a button hasn't been pressed
         if RPS_in_c = 2 then
            RPS_in_c <= 0;
         else
            RPS_in_c <= RPS_in_c + 1;
         end if;
         computer_select_digit <= RPS_out_c;
         --computer_select <= RPS_in_c;
         player_select_digit <= "1111111";

        elsif choice = '1' then
         computer_select_digit <= RPS_out_c;
         player_select_digit <= RPS_out_p;
         --computer_select <= RPS_in_c; 
         -- pass scores to decoder
        end if;
    end if;
    end process;


end Behavioral;
