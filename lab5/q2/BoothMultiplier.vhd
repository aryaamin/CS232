library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BoothMultiplier is
port ( clk, rst : in std_logic;
a, b : in std_logic_vector (3 downto 0);
result : out std_logic_vector (7 downto 0) );
end entity;

architecture BoothMultiplier_arc of BoothMultiplier is

	signal pp1: std_logic_vector (7 downto 0);
	signal pp2: std_logic_vector (7 downto 0);
	signal state: std_logic;

begin

	process (clk, a, b)
	begin
	
		if rising_edge(clk) then
			if rst = '1' then
				state <= '1';
			else
				state <= not state;
			end if;
		end if;
	end process;
	
	process (state)
	begin
		if rst /= '1' then
			if state = '0' then
				if b(0) = '0' and b(1) = '0' then			
					pp1 <= "00000000";
				elsif b(0) = '1' and b(1) = '0' then	
					pp1 <= "0000" & a;
				elsif b(0) = '0' and b(1) = '1' then	
					pp1 <= "000" & a & "0";
				else
					pp1 <= std_logic_vector(unsigned(std_logic_vector(unsigned (not ("0000" & a)) + 1)) + unsigned("00" & a & "00"));
				end if;
				if b(2) = '0' and b(3) = '0' then			
					pp2 <= "00000000";
				elsif b(2) = '1' and b(3) = '0' then	
					pp2 <= "0000" & a;
				elsif b(2) = '0' and b(3) = '1' then	
					pp2 <= "000" & a & "0";
				else
					pp2 <= (std_logic_vector(unsigned(std_logic_vector(unsigned (not ("0000" & a)) + 1)) + unsigned("00" & a & "00")));
				end if;
			else
				result <= std_logic_vector(unsigned(pp1) + unsigned(pp2(5 downto 0) & "00"));
			end if;	
		end if;
	end process;

end architecture;