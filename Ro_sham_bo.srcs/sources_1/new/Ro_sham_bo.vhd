----------------------------------------------------------------------------------
-- Engineer: Aaron Crump
-- Class: 
-- Create Date: 01/22/2017 02:03:08 PM
-- Design Name: 
-- Module Name: seven_seg - Behavioral
-- Project Name: ROSHAMBO
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
port (clock : in std_logic;
      computer_score_out : out std_logic_vector (6 downto 0);
      player_score_out : out std_logic_vector (6 downto 0);
      player_select_out : out std_logic_vector (6 downto 0);
      computer_select_out : out std_logic_vector (6 downto 0); 
      btn_l, btn_r, btn_c : in std_logic);
end component;

component clk
    Port ( clock_in : in STD_LOGIC;
           clock_out_slow: out std_logic;
           clk_out : out std_logic;
           clock_out_fast : out std_logic);
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

signal clock_divide : std_logic; --4ms clock
signal slow_clk : std_logic; -- 10 ms clock
signal player_select_digit : std_logic_vector (6 downto 0); --player choice rock, paper, scissors (7 bit digit form)
signal computer_select_digit : std_logic_vector (6 downto 0); -- computer RPS selection (7 bit digit form)
signal player_score_digit : std_logic_vector (6 downto 0); -- player RPS score (digit)
signal computer_score_digit : std_logic_vector (6 downto 0);-- computer RPS score (digit)
signal fast_clock : std_logic; -- 1/10 ms clock
signal btn_out_r : std_logic; -- button output to verify debounced button signals
signal btn_out_l : std_logic;
signal btn_out_c : std_logic;


begin
U1: clk port map(clock_in => clock, clk_out => clock_divide, clock_out_slow => slow_clk, clock_out_fast => fast_clock);
U2: mux port map(seven => seven, an_sel => an_sel, clk => clock_divide, player_select_digit => player_select_digit,
     player_score_digit => player_score_digit, computer_select_digit => computer_select_digit, 
     computer_score_digit => computer_score_digit);
U3: debouncer port map(clk => fast_clock, btn_out => btn_out_l, btn_in => btn_left);
U4: debouncer port map(clk => fast_clock, btn_out => btn_out_r, btn_in => btn_right);
U5: debouncer port map(clk => fast_clock, btn_out => btn_out_c, btn_in => btn_cntr);  
U8: roshambo_logic port map(clock => slow_clk, btn_l => btn_out_l, btn_r => btn_out_r, btn_c => btn_out_c,
    player_select_out => player_select_digit, computer_select_out => computer_select_digit, player_score_out => player_score_digit, 
    computer_score_out => computer_score_digit);


end Behavioral;
