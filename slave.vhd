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
----------------------------------------------------------------------------------
-- Defined within are
--
-- width_cnt
-- 
----------------------------------------------------------------------------------

ENTITY slave IS
    PORT ( clk				: IN	STD_LOGIC;
           triggers		: OUT	STD_LOGIC_VECTOR((num_trig-1)*(1+num_fpga) downto (num_trig-1)*num_fpga));
END slave;

ARCHITECTURE Behavioral OF slave IS
	SIGNAL count			: STD_LOGIC_VECTOR(width_cnt - 1 downto 0):= (others => '0');
	SIGNAL temp				: STD_LOGIC_VECTOR(3 downto 0)				:= (others => '0');
	
	COMPONENT counter 
		GENERIC(
				cnt_width 	: integer); 
		PORT( 
				clk			: IN	std_logic; 
				cnt_enable	: IN	std_logic; 
				reset			: IN	std_logic; 
				cnt_out		: OUT std_logic_vector(cnt_width - 1 downto 0) ); 
	END COMPONENT; 
	
	COMPONENT fire
		GENERIC(
				cnt_width	: integer;
				trig_num		: integer); 
		PORT(
				count			: IN	std_logic_vector(cnt_width - 1 downto 0);
				time_on		: IN	std_logic_vector(cnt_width - 1 downto 0);          
				time_off		: IN	std_logic_vector(cnt_width - 1 downto 0);          
				trigger		: OUT	std_logic);
	END COMPONENT;
	
begin
			
	global_counter: counter 
	GENERIC MAP(	
		cnt_width		=> width_cnt)
	PORT MAP(
		clk         	=> clk,
		cnt_enable		=> '1',
		reset				=> '0',
		cnt_out     	=> count);

	trigger_bindings:	
	for I in 0 to num_trig - 1 generate
		fire_trigger: fire 
		GENERIC MAP(	
			cnt_width 	=> width_cnt,
			trig_num		=> num_trig)
		PORT MAP(
			count			=> count,
			time_on		=> table_on(I),
			time_off 	=> table_off(I),
			trigger		=> temp(I));
	end generate trigger_bindings;
	
	
	--triggers(4) <= count1(23);
	triggers(0) <= temp(0) XOR '0';
	triggers(1) <= temp(1) XOR '0';
	triggers(2) <= temp(2) XOR '0';
	triggers(3) <= temp(3) XOR '0';
	
	
end Behavioral;