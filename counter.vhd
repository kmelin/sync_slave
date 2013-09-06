----------------------------------------------------------------------------------
-- Company:				Unversity of Texas at Austin
-- Designer:			Kevin Melin
-- 
-- Create Date:		20:00:13 08/29/2013 
-- Design Name:		
-- Module Name:		fire - Behavioral 
-- Project Name: 
-- Target Devices: 	ztex 1.11a + Analog Experimental Board
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.timing_definitions.ALL;

entity counter is 
	generic(
		cnt_width : integer := width_cnt); 
	port( 
		clk			: in  std_logic; 
		cnt_enable	: in  std_logic; 
		reset			: in  std_logic; 
		cnt_out		: out std_logic_vector(cnt_width-1 downto 0)); 
end counter; 

architecture RTL_counter of counter is 
	signal countL : std_logic_vector(cnt_out'range); 
	begin 
		P1: process (reset, clk, cnt_enable) 
		begin 
			if (reset = '1') then 
				countL <= (others => '0'); 
			elsif (rising_edge(clk)) then 
				if (cnt_enable = '1') then 
					countL <= countL + 1; 
				end if; 
			end if; 
		end process; 
	cnt_out <= countL; 
end RTL_counter; 
