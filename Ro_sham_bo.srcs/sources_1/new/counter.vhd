----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2017 08:20:44 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
Port (btn_up : in std_logic;
      clock_in : in std_logic;
      count_out : out std_logic_vector (3 downto 0)); -- counts up to 9 to keep score
end counter;

architecture Behavioral of counter is
signal button_count : std_logic_vector (3 downto 0);
begin

binary_counter: process(btn_up, clock_in)
variable ten_times_clock : std_logic_vector (3 downto 0);
    begin
        if btn_up = '1' then
            if rising_edge(clock_in) then
                ten_times_clock := ten_times_clock + 1;
                case ten_times_clock is
                when "1111" =>
                    button_count <= button_count + 1;
                        if button_count = "1111100111" then
                            button_count <= "0000000000";
                        end if;
                when others => null;
                end case;
             end if;
         end if;    
    end process;

end Behavioral;
