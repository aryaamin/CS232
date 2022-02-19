library ieee;
use ieee.std_logic_1164.all;

entity Comparator is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Comparator_arc of Comparator is

	signal s: std_logic_vector (3 downto 0);
	
	component xnor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
		
		XnorInst1: xnor_gate
			port map(a=>a(0), b=>b(0), c=>s(0));
		XnorInst2: xnor_gate
			port map(a=>a(1), b=>b(1), c=>s(1));
		XnorInst3: xnor_gate
			port map(a=>a(2), b=>b(2), c=>s(2));
		XnorInst4: xnor_gate
			port map(a=>a(3), b=>b(3), c=>s(3));

		result(1)<=s(3) and s(2) and s(1) and s(0);

		result(2)<=(a(3) and (not b(3))) or
			 (s(3) and a(2) and (not b(2))) or
			 (s(3) and s(2) and a(1)and (not b(1))) or
			 (s(3) and s(2) and s(1) and a(0) and (not b(0)));

		result(0)<=(b(3) and (not a(3))) or
			 (s(3) and b(2) and (not a(2)))or
			 (s(3) and s(2) and b(1)and (not a(1))) or
			 (s(3) and s(2) and s(1) and b(0) and (not a(0)));

	
		
end architecture;
