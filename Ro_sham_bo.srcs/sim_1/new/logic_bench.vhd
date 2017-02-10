-----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/09/2017 06:49:40 PM
-- Design Name: 
-- Module Name: debounce_bench - Behavioral
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

entity logic_bench is
--  Port ( );
end logic_bench;

architecture Behavioral of logic_bench is
component roshambo_logic
port (player_select : in integer;
      computer_select : in integer;
      computer_score : out integer;
      player_score : out integer);
end component;


signal player_select : integer := 0;--inputs
signal computer_select : integer := 0;
signal computer_score : integer := 0;--outputs
signal player_score : integer := 0;

--procedure monitor(shouldbe : in std_logic) is --monitor procedure
--variable lout : line;
--begin
--write(lout, now, right, 10, ns);
--write(lout, string'(" player_select -->"));
--write(lout, player_select);
--write(lout, string'(" computer_select -->"));
--write(lout, computer_select);
--write(lout, string'(" player_score -->"));
--write(lout, player_score);
--write(lout, string'(" computer_score -->"));
--write(lout, computer_score);
--writeline(output, lout);
--assert btn_out = shouldbe report "test failed" severity error;
--end monitor;

begin
M4: roshambo_logic port map (player_select => player_select, computer_select => computer_select, computer_score => computer_score,
    player_score => player_score);
   
--clk_process: process
--   begin
--        clk <= '0';
--        wait for 1 ns;  --for 1 ps signal is '0'.
--        clk <= '1';
--        wait for 1 ns;  --for next 1 ps signal is '1'.
--   end process;   
stim_process: process
begin
-- 0 = rock, 1 = paper, 2 = scissors

        wait for 5 ns;
        player_select <= 0; -- this series tests all 9 possible combinations
        computer_select <= 0; -- scores should increase in the order -,c,p,p,-,c,c,p,-
        wait for 1 ns;    
        player_select <= 0;
        computer_select <= 1;
        wait for 1 ns;
        player_select <= 0;
        computer_select <= 2;
        wait for 1 ns;    
        player_select <= 1;
        computer_select <= 0;
        wait for 1 ns;
        player_select <= 1;
        computer_select <= 1;
        wait for 1 ns;
        player_select <= 1;
        computer_select <= 2;
        wait for 1 ns;
        player_select <= 2;
        computer_select <= 0;
        wait for 1 ns;
        player_select <= 2;
        computer_select <= 1;
        wait for 1 ns;
        player_select <= 2;
        computer_select <= 2;
        wait for 5 ns;
        wait;


--wait for 100 ns;         
--        report "beginning of logic test" severity note;
            
--        clk <= '1'; btn_in <= '1'; 
--        wait for 1 ns;
--        monitor('1');
           
--        clk <= '1'; btn_in <= '0'; 
--        wait for 1 ns;
--        monitor('1');
        
--    clk <= '0'; btn_in <= '1'; 
--    wait for 1 ns;
--    monitor('0');   
    
--    clk <= '0'; btn_in <= '1'; 
--    wait for 1 ns;
--    monitor('0');
--    wait;
end process;   
end Behavioral;
