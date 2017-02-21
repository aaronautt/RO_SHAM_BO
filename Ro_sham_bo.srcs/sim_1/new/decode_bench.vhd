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

procedure Monitor(shouldbe: in STD_logic_vector(6 downto 0)) is
variable lout: line;
begin
    write(lout, now, right, 10, ns);
    write(lout, string'(" Rock Paper Scissors selection --> "));
    write(lout, RPS_in);
    write(lout, string'(" RPS seven segment --> "));
    write(lout, RPS_out);
    write(lout, string'(" Score in --> "));
    write(lout, digit_in);
    write(lout, string'(" Score out --> "));
    write(lout, digit_out);
    writeline(output, lout);
    assert digit_out = shouldbe report "Test Failed" severity failure;
end Monitor;

begin
M3: decoder port map (RPS_in => RPS_in, RPS_out => RPS_out, digit_in => digit_in, digit_out => digit_out);
   
stim_process: process
begin

        wait for 5 us;
        RPS_in <= 0; digit_in <= 0;
        wait for 1 us;
        Monitor("0000001");
        
        digit_in <= 6;
        wait for 1 us;    
        Monitor("0100000");
        
        digit_in <= 4;
        wait for 1us;
        Monitor("1001100");
        
        digit_in <= 11;
        wait for 1us;
        Monitor("1001100");

end process;   
end Behavioral;
