library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity rlencoding is
	port (clk, rst: in std_logic;
			x: in std_logic_vector (7 downto 0);
			y: out std_logic_vector (7 downto 0);
			df: out std_logic);
end entity;

architecture rlencoding_arc of rlencoding is
	
	signal c: std_logic_vector (7 downto 0) := "00000000";
	signal l: std_logic_vector (7 downto 0) := "00000000";
	signal buff: std_logic_vector (519 downto 0) := (others => '0'); 
	signal n: integer;
	signal q: integer := 0;
	
begin
	process (clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				c <= "00000000";
				l <= "00000000";
				buff(519 downto 0) <= (others => '0');
			else		
				q <= q+1;			
				if q > 65 then
					y <= buff(519 downto 512);
					if buff(519 downto 512) = "00000000" then
						df <= '0';
					else
						df <= '1';
					end if;
					for i in 0 to 63 loop
						if buff((519-8*i-8) downto (519-8*i-7-8)) /= "00000000" then
							buff((519-8*i) downto (519-8*i-7)) <= buff((519-8*i-8) downto (519-8*i-7-8));
						else
							buff((519-8*i) downto (519-8*i-7)) <= "00000000";
							exit;
						end if;
					end loop;
				else
					y <= buff(519 downto 512);
					if buff(519 downto 512) = "00000000" then
						df <= '0';
					else
						df <= '1';
					end if;
					
					for i in 0 to 63 loop
						if buff((519-8*i-8) downto (519-8*i-7-8)) /= "00000000" then
							buff((519-8*i) downto (519-8*i-7)) <= buff((519-8*i-8) downto (519-8*i-7-8));
						else
							n <= i;
							exit;
						end if;
					end loop;
					
					if (l = x or l="00000000") then
						if c = "00000000" then
							c <= "00000001";
							for i in 0 to 63 loop
								if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
									buff((519-8*i) downto (519-8*i-7)) <= "00000000";
									exit;
								end if;
							end loop;
						elsif c = "00000001" then
							c <= "00000010";
							for i in 0 to 63 loop
								if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
									buff((519-8*i) downto (519-8*i-7)) <= "00000000";
									exit;
								end if;
							end loop;
						elsif c = "00000010" then
							c <= "00000011";
							for i in 0 to 63 loop
								if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
									buff((519-8*i) downto (519-8*i-7)) <= "00000000";
									exit;
								end if;
							end loop;
						elsif c = "00000011" then
							c <= "00000100";
							for i in 0 to 63 loop
								if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
									buff((519-8*i) downto (519-8*i-7)) <= "00000000";
									exit;
								end if;
							end loop;
						elsif c = "00000100" then
							c <= "00000101";
							for i in 0 to 63 loop
								if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
									buff((519-8*i) downto (519-8*i-7)) <= "00000000";
									exit;
								end if;
							end loop;
						elsif c = "00000101" then
							if l /= "00011011" then
								c <= "00000001";
								if buff(519 downto 512) = "00000000" then
									buff(519 downto 512) <= "00011011";
									buff((519-8) downto (519-8-7)) <= c;
									buff((519-16) downto (519-16-7)) <= l;
								else
	--								buff((519-8*n+8) downto (519-8*n-7+8)) <= "00011011";
	--								buff((519-8*n) downto (519-8*n-7)) <= c;
	--								buff((519-8*n-8) downto (519-8*n-7-8)) <= l;
									for i in 0 to 62 loop
										if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
											buff((519-8*i) downto (519-8*i-7)) <= "00011011";
											buff((519-8*i-8) downto (519-8*i-7-8)) <= c;
											buff((519-8*i-16) downto (519-8*i-7-16)) <= l;
											exit;
										end if;
									end loop;
								end if;
							else
								c <= "00000110";
								for i in 0 to 63 loop
									if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
										buff((519-8*i) downto (519-8*i-7)) <= "00000000";
										exit;
									end if;
								end loop;
							end if;
						elsif c = "00000110" and l = "00011011" then
							c <= "00000001";
							if buff(519 downto 512) = "00000000" then
								buff(519 downto 512) <= "00011011";
								buff((519-8) downto (519-8-7)) <= c;
								buff((519-16) downto (519-16-7)) <= l;
							else
	--							buff((519-8*n+8) downto (519-8*n-7+8)) <= "00011011";
	--							buff((519-8*n) downto (519-8*n-7)) <= c;
	--							buff((519-8*n - 8) downto (519-8*n-7 - 8)) <= l;
								for i in 0 to 62 loop
									if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
										buff((519-8*i) downto (519-8*i-7)) <= "00011011";
										buff((519-8*i-8) downto (519-8*i-7-8)) <= c;
										buff((519-8*i-16) downto (519-8*i-7-16)) <= l;
										exit;
									end if;
								end loop;
							end if;
						end if;
					else
						if c = "00000001" and l /= "00011011" then
							if buff(519 downto 512) = "00000000" then
								buff(519 downto 512) <= l;
							else
	--							buff((519-8*n+8) downto (519-8*n-7+8)) <= l;
								for i in 0 to 63 loop
									if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
										buff((519-8*i) downto (519-8*i-7)) <= l;
										exit;
									end if;
								end loop;
							end if;
						elsif c = "00000010" and l /= "00011011" then
							if buff(519 downto 512) = "00000000" then
								buff(519 downto 512) <= l;
								buff(519-8 downto 512-8) <= l;
							else
	--							buff((519-8*n+8) downto (519-8*n-7+8)) <= l;
	--							buff((519-8*n) downto (519-8*n-7)) <= l;
								for i in 0 to 63 loop
									if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
										buff((519-8*i) downto (519-8*i-7)) <= l;
										buff((519-8*i-8) downto (519-8*i-7-8)) <= l;
										exit;
									end if;
								end loop;
							end if;
						else
							if buff(519 downto 512) = "00000000" then
								buff(519 downto 512) <= "00011011";
								buff((519-8) downto (519-8-7)) <= c;
								buff((519-16) downto (519-16-7)) <= l;
							else
	--							buff((519-8*n+8) downto (519-8*n-7+8)) <= "00011011";
	--							buff((519-8*n) downto (519-8*n-7)) <= c;
	--							buff((519-8*n - 8) downto (519-8*n-7 - 8)) <= l;
								for i in 0 to 62 loop
									if buff((519-8*i-8) downto (519-8*i-7-8)) = "00000000" then
										buff((519-8*i) downto (519-8*i-7)) <= "00011011";
										buff((519-8*i-8) downto (519-8*i-7-8)) <= c;
										buff((519-8*i-16) downto (519-8*i-7-16)) <= l;
										exit;
									end if;
								end loop;
							end if;
						end if;
						c <= "00000001";
					end if;
					l <= x;	
				end if;
			end if;
		end if;
	end process;
end architecture;