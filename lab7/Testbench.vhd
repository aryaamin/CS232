library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all; 
use ieee.numeric_std.all;

entity Testbench is
end entity;

architecture Behave of Testbench is 
	component TrafficLightsController is
		port ( clk, rst, tr1, tr4 : in std_logic;
		r, g, y: out std_logic_vector (4 downto 0) );
	end component;

  signal clk, rst, tr1, tr4 : std_logic;
  signal r, g, y : std_logic_vector(4 downto 0);

  
begin
	dut_instance: TrafficLightsController
		port map (clk => clk, rst=> rst, tr1=>tr1, tr4=>tr4, r=>r, g=>g, y=>y);
		
	process
		variable resetatstart : std_logic := '1';		
		variable clock, reset : std_logic := '1';
		variable seed1 : positive := 1;
		variable seed2 : positive := 2;
		variable seed3 : positive := 3;
		variable seed4 : positive := 4;
		variable r1, r2 : real;
	begin
		for i in 0 to 1000 loop
		
			if resetatstart = '1' then
				reset := '1';
				resetatstart := '0';
			else
				reset := '0';
			end if;
		
			clock := '0';
			rst <= reset;
			clk <= clock;
			wait for 2.5 sec;
			
			clock := '1';
			uniform(seed1, seed2, r1);
			if (r1 < 0.5) then
				tr1 <= '0';
			else
				tr1 <= '1';
			end if;
			uniform(seed3, seed4, r2);
			if (r2 < 0.5) then
				tr4 <= '0';
			else
				tr4 <= '1';
			end if;
			clk <= clock;				
			wait for 2.5 sec;
				
		end loop;
		wait;
	end process;
	
end architecture;