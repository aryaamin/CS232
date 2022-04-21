library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mod10UpDown is
	port ( clk, rst, up : in std_logic;
				count: out std_logic_vector (3 downto 0) );
end entity;

architecture Mod10UpDown_arc of Mod10UpDown is

	signal cnt: std_logic_vector (3 downto 0) := "0000";

begin

	process (clk, rst, up)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				count <= "0000";
				cnt <= "0000";
			else	
				if up = '1' then
					if cnt = "1001" then
						count <= "0000";
						cnt <= "0000";
					else
						count <= std_logic_vector( unsigned(cnt) + 1 );
						cnt <= std_logic_vector( unsigned(cnt) + 1 );
					end if;
				else
					if cnt = "0000" then
						cnt <= "1001";
						count <= "1001";
					else
						cnt <= std_logic_vector( unsigned(cnt) - 1 );
						count <= std_logic_vector( unsigned(cnt) - 1 );
					end if;
				end if;
			end if;
		end if;
	end process;
	
end architecture;