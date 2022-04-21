library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity TrafficLightsController is
port ( clk, rst, tr1, tr4 : in std_logic;
r, g, y: out std_logic_vector (4 downto 0) );
end entity;

architecture TrafficLightsController_arc of TrafficLightsController is

	signal n: integer := 2;
	signal c: integer := 1;
	signal yr: std_logic := '0';
	signal p1, p4: std_logic := '0';
	
begin
	process (clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				n <= 2;
				c <= 1;
				yr <= '0';
				p1 <= '0';
				p4 <= '0';
				for i in 0 to 4 loop
					if i = 2 then
						r(i) <= '0';
						g(i) <= '1';
						y(i) <= '0';
						c <= 1;
					else
						r(i) <= '1';
						g(i) <= '0';
						y(i) <= '0';
					end if;
				end loop;
			else	
				if c = 6 and (n = 1 or n = 4) and yr = '0' then
					for i in 0 to 4 loop
						if i = n then
							r(i) <= '0';
							g(i) <= '0';
							y(i) <= '1';
							c <= 7;
						else
							r(i) <= '1';
							g(i) <= '0';
							y(i) <= '0';
						end if;
					end loop;
					n <= ((n + 1) rem 5);
					yr <= '1';
				elsif c = 7 and (n = 2 or n = 0) and yr = '1' then
					for i in 0 to 4 loop
						if i = n then
							r(i) <= '0';
							g(i) <= '1';
							y(i) <= '0';
							c <= 1;
						else
							r(i) <= '1';
							g(i) <= '0';
							y(i) <= '0';
						end if;
					end loop;
					yr <= '0';
				elsif c = 12 and (n = 0 or n = 2 or n = 3) and yr = '0' then
					for i in 0 to 4 loop
						if i = n then
							r(i) <= '0';
							g(i) <= '0';
							y(i) <= '1';
							c <= 13;
						else
							r(i) <= '1';
							g(i) <= '0';
							y(i) <= '0';
						end if;
					end loop;
					if tr1 = '0' and n = 0 then
						n <= 2;
						p1 <= '1';
					elsif tr4 = '0' and n = 3 then
						n <= 0;
						p4 <= '1';
					else
						n <= ((n + 1) rem 5);
					end if;
					yr <= '1';
				elsif c = 13 and (n = 1 or n = 3 or n = 4) and yr = '1' then
					for i in 0 to 4 loop
						if i = n then
							r(i) <= '0';
							g(i) <= '1';
							y(i) <= '0';
						else
							r(i) <= '1';
							g(i) <= '0';
							y(i) <= '0';
						end if;
					end loop;
					c <= 1;
					yr <= '0';
				elsif c = 13 and n = 0 and yr = '1' and p4 = '1' then
					for i in 0 to 4 loop
						if i = n then
							r(i) <= '0';
							g(i) <= '1';
							y(i) <= '0';
						else
							r(i) <= '1';
							g(i) <= '0';
							y(i) <= '0';
						end if;
					end loop;
					c <= 1;
					yr <= '0';
					p4 <= '0';
				elsif c = 13 and n = 2 and yr = '1' and p1 = '1' then
					for i in 0 to 4 loop
						if i = n then
							r(i) <= '0';
							g(i) <= '1';
							y(i) <= '0';
						else
							r(i) <= '1';
							g(i) <= '0';
							y(i) <= '0';
						end if;
					end loop;
					c <= 1;
					yr <= '0';
					p1 <= '0';
				else
					c <= c+1;
				end if;
			end if;
		end if;
	end process;
end architecture;