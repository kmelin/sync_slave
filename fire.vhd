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
use IEEE.NUMERIC_STD.ALL;

library work;
use work.timing_definitions.ALL;

entity fire is
	generic(
		cnt_width: integer;
		trig_num	: integer ); 
	Port(
		count		: in	STD_LOGIC_VECTOR(cnt_width - 1 downto 0);
		time_on	: in	STD_LOGIC_VECTOR(cnt_width - 1 downto 0);
		time_off	: in	STD_LOGIC_VECTOR(cnt_width - 1 downto 0);
		trigger	: out	STD_LOGIC );
end fire;

architecture Behavioral of fire is
begin
	trigger <=	'1' when (UNSIGNED(count) >= UNSIGNED(time_on)) 
								and (UNSIGNED(count) <= UNSIGNED(time_off))	else
					'0' ;
end Behavioral;