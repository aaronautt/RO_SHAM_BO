----------------------------------------------------------------------------------
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

entity debounce_bench is
--  Port ( );
end debounce_bench;

architecture Behavioral of debounce_bench is
component debouncer
    port(clk : in std_logic;
         btn_in : in std_logic;
         btn_out : out std_logic);
end component;

signal clk, btn_in : std_logic := '0'; --inputs
signal btn_out : std_logic; --outputs


begin
M1: debouncer port map (clk => clk, btn_in => btn_in, btn_out => btn_out);

clk_process: process
   begin
        clk <= '0';
        wait for 1 ps;  --for 1 ps signal is '0'.
        clk <= '1';
        wait for 1 ps;  --for next 1 ps signal is '1'.
   end process;
   
stim_process: process
begin

--wait for 100 ns;         
        wait for 7 ns;
        btn_in <='1';
        wait for 500 ns;    
        btn_in <='0'; 
        wait for 17 ns;
        btn_in <= '1';
        wait for 1000 ns;    
        btn_in <= '0'; 
        wait;
  end process;
         
end Behavioral;
