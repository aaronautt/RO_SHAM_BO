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

entity decode_bench is
--  Port ( );
end decode_bench;

architecture Behavioral of decode_bench is
component decoder 
  Port (RPS_in : in integer;
        RPS_out : out std_logic_vector (6 downto 0);
        digit_in : in integer;
        digit_out : out std_logic_vector (6 downto 0));
end component;


signal RPS_in : integer;
signal RPS_out : std_logic_vector (6 downto 0);
signal digit_in : integer;
signal digit_out : std_logic_vector (6 downto 0);


begin
M3: decoder port map (RPS_in => RPS_in, RPS_out => RPS_out, digit_in => digit_in, digit_out => digit_out);
   
stim_process: process
begin

        wait for 5 ns;
        RPS_in <= 0;
        digit_in <= 0;
        wait for 1 ns;    
        digit_in <= 1;
        RPS_in <= 1;
        wait for 1 ns;
        RPS_in <= 2;
        digit_in <= 2;
        wait for 1 ns;    
        digit_in <= 3;
        wait for 1 ns;
        digit_in <= 4;
        wait for 1 ns;
        digit_in <= 5;
        wait for 1 ns;
        digit_in <= 6;
        wait for 1 ns;
        digit_in <= 7;
        wait for 1 ns;
        digit_in <= 8;
        wait for 1 ns;
        digit_in <= 9;        
        wait for 5 ns;
        wait;

end process;   
end Behavioral;
