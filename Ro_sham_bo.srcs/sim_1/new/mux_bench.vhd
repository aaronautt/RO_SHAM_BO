

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;
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

entity mux_bench is
--  Port ( );
end mux_bench;

architecture Behavioral of mux_bench is
component mux
 port(an_sel : out std_logic_vector (3 downto 0);
      seven : out std_logic_vector (6 downto 0);
      player_select_digit : in std_logic_vector (6 downto 0);
      computer_select_digit : in std_logic_vector (6 downto 0);
      player_score_digit : in std_logic_vector (6 downto 0);
      computer_score_digit : in std_logic_vector (6 downto 0);
      clk : in std_logic);
end component;

signal clk : std_logic := '0'; --inputs
signal player_select_digit : std_logic_vector (6 downto 0);
signal computer_select_digit : std_logic_vector (6 downto 0);
signal player_score_digit : std_logic_vector (6 downto 0);
signal computer_score_digit : std_logic_vector (6 downto 0);
signal an_sel : std_logic_vector (3 downto 0);--outputs
signal seven : std_logic_vector (6 downto 0);


begin
M2: mux port map (clk => clk, player_select_digit => player_select_digit, computer_select_digit => computer_select_digit, 
player_score_digit => player_score_digit, computer_score_digit => computer_score_digit, an_sel => an_sel, seven => seven);
   
clk_process: process
   begin
        clk <= '0';
        wait for 1 ns;  --for 1 ps signal is '0'.
        clk <= '1';
        wait for 1 ns;  --for next 1 ps signal is '1'.
   end process;   
stim_process: process
begin

        wait for 5 ns;
        player_select_digit <= "0000001";
        wait for 5 ns;    
        computer_select_digit <= "1001111";
        wait for 1 ns;
        player_score_digit <= "0100100";
        wait for 1 ns;    
        computer_score_digit <= "0001111";
        wait for 1 ns;
        wait for 5 ns;
        wait;


end process;   
end Behavioral;
