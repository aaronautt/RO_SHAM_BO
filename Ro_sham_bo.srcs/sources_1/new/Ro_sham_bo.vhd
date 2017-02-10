----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2017 02:03:08 PM
-- Design Name: 
-- Module Name: seven_seg - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_seg is
    Port ( clock : in std_logic;
           --sel : in STD_LOGIC_VECTOR (2 downto 0);
            -- sw2 is msb, sw0 is lsb
           seven : inout std_logic_vector (6 downto 0);
           --bit 6 = segment a, downto bit 0 = g
           -- button to select rock
           btn_left : in std_logic;
           -- button to select paper 
           btn_right : in std_logic;
           -- button to select scissors.
           btn_cntr : in std_logic;
           
           an_sel : out std_logic_vector (3 downto 0)
           --selection of which display to show
           );
end seven_seg;

architecture Behavioral of seven_seg is

component roshambo_logic
port (
      player_select : in integer;
      computer_select : in integer;
      computer_score : out integer;
      player_score : out integer);
end component;

component clk
    Port ( clock_in : in STD_LOGIC;
           clock_out_slow: out std_logic;
           clk_out : out std_logic;
           clock_out_fast : out std_logic);
end component;

component decoder 
  Port (RPS_in : in integer;
        RPS_out : out std_logic_vector (6 downto 0);
        digit_in : in integer;
        digit_out : out std_logic_vector (6 downto 0));
end component;


component mux
 port(an_sel : out std_logic_vector (3 downto 0);
      seven : out std_logic_vector (6 downto 0);
      player_select_digit : in std_logic_vector (6 downto 0);
      computer_select_digit : in std_logic_vector (6 downto 0);
      player_score_digit : in std_logic_vector (6 downto 0);
      computer_score_digit : in std_logic_vector (6 downto 0);
      clk : in std_logic);
end component;

component debouncer
    port(clk : in std_logic;
         btn_in : in std_logic;
         btn_out : out std_logic);
end component;

signal RPS_in_p : integer := 1; -- selection of rock paper or scissors
signal RPS_out_p : std_logic_vector (6 downto 0); -- decoded RPS representation of the three letters
signal digit_in_p : integer; -- binary counter from 0 to 9
signal digit_out_p : std_logic_vector (6 downto 0); -- decoded digit for seven segment display
signal clock_divide : std_logic; --4ms clock
signal RPS_in_c : integer := 1; -- selection of rock paper or scissors
signal RPS_out_c : std_logic_vector (6 downto 0); -- decoded RPS representation of the three letters
signal digit_in_c : integer; -- binary counter from 0 to 9
signal digit_out_c : std_logic_vector (6 downto 0); -- decoded digit for seven segment display
signal slow_clk : std_logic; -- 10 ms clock
signal player_select : integer; --player choice rock, paper, scissors
signal computer_select : integer; -- computer RPS
signal player_select_digit : std_logic_vector (6 downto 0); --player choice rock, paper, scissors (7 bit digit form)
signal computer_select_digit : std_logic_vector (6 downto 0); -- computer RPS selection (7 bit digit form)
signal player_score_digit : std_logic_vector (6 downto 0); -- player RPS score (digit)
signal computer_score_digit : std_logic_vector (6 downto 0);-- computer RPS score (digit)
signal player_score : integer := 0; -- player RPS score (value) counts up to 9
signal computer_score : integer := 0;-- computer RPS score (value) count up to 9
signal fast_clock : std_logic; -- 1/10 ms clock
signal btn_out_r : std_logic; -- button output to verify debounced button signals
signal btn_out_l : std_logic;
signal btn_out_c : std_logic;
signal choice : std_logic; -- flag to show that game has started


begin
U1: clk port map(clock_in => clock, clk_out => clock_divide, clock_out_slow => slow_clk, clock_out_fast => fast_clock);
U2: mux port map(seven => seven, an_sel => an_sel, clk => clock_divide, player_select_digit => player_select_digit, player_score_digit => player_score_digit,
    computer_select_digit => computer_select_digit, computer_score_digit => computer_score_digit);
U3: debouncer port map(clk => clock, btn_out => btn_out_l, btn_in => btn_left);
U4: debouncer port map(clk => clock, btn_out => btn_out_r, btn_in => btn_right);
U5: debouncer port map(clk => clock, btn_out => btn_out_c, btn_in => btn_cntr);  
U6: decoder port map(RPS_in => RPS_in_p, RPS_out => RPS_out_p, digit_in => digit_in_p, digit_out => digit_out_p);
U7: decoder port map(RPS_in => RPS_in_c, RPS_out => RPS_out_c, digit_in => digit_in_c, digit_out => digit_out_c);
U8: roshambo_logic port map(player_select => player_select, computer_select => computer_select, player_score => player_score, 
    computer_score => computer_score);


kicked: process(slow_clk, btn_out_r, btn_out_l, btn_out_c)
begin  
if rising_edge(slow_clk) then
    if btn_out_r = '0' and btn_out_l = '0' and btn_out_c = '0' then
        choice <= '0';
    elsif btn_out_r = '1' then
        RPS_in_p <= 2;
        choice <= '1';
    elsif btn_out_l = '1' then
        RPS_in_p <= 0;   
        choice <= '1';
    elsif btn_out_c <= '1' then
        RPS_in_p <= 1;
        choice <= '1';
    else choice <= 'X';
    end if;
end if;
end process;



roshambo_rotate: process(choice, slow_clk)

    begin
    
    if rising_edge(slow_clk) then
    digit_in_p <= player_score;
    digit_in_c <= computer_score;
        if choice = '0' then -- flag check to make sure a button hasn't been pressed
         if RPS_in_c = 2 then 
            RPS_in_c <= 0;
         else
            RPS_in_c <= RPS_in_c + 1;
         end if;            
         computer_select_digit <= RPS_out_c;
         computer_select <= RPS_in_c;
         player_select_digit <= "1111111";
         
        elsif choice = '1' then
         computer_select_digit <= RPS_out_c;
         player_select_digit <= RPS_out_p;
         computer_score_digit <= digit_out_c;
         player_score_digit <= digit_out_p;
         computer_select <= RPS_in_c; 
         -- pass scores to decoder
        end if;
    end if;     
    end process;

end Behavioral;