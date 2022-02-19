library ieee;
use ieee.std_logic_1164.all;

entity Subtractor is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Subtractor_arc of Subtractor is

	signal c0: std_logic := '0';
	signal ca1, ca2, ca3, k0, k1, k2, k3: std_logic;
	signal d: std_logic_vector (3 downto 0);

	component OnebitFullAdd
		port (a,b,cin: in std_logic; sum,cout: out std_logic);
	end component;
	
	component xor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin

		XorInst1: xor_gate
			port map (a=>c0, b=>b(0), c=>d(0));
		XorInst2: xor_gate
			port map (a=>c0, b=>b(1), c=>d(1));
		XorInst3: xor_gate
			port map (a=>c0, b=>b(2), c=>d(2));
		XorInst4: xor_gate
			port map (a=>c0, b=>b(3), c=>d(3));	
		XorInst5: xor_gate
			port map (a=>a(0), b=>d(0), c=>k0);
		XorInst6: xor_gate
			port map (a=>a(1), b=>d(1), c=>k1);
		XorInst7: xor_gate
			port map (a=>a(2), b=>d(2), c=>k2);
		XorInst8: xor_gate
			port map (a=>a(3), b=>d(3), c=>k3);	

		ca1 <= (c0 and k0) or (a(0) and d(0));
		ca2 <= (ca1 and k1) or (a(1) and d(1));
		ca3 <= (ca2 and k2) or (a(2) and d(2));
		result(4) <= (ca3 and k3) or (a(3) and d(3));
		
		FullAdderInst1: OnebitFullAdd
			port map (a=>a(0), b=>d(0), cin=>c0, sum=>result(0));
		FullAdderInst2: OnebitFullAdd
			port map (a=>a(1), b=>d(1), cin=>ca1, sum=>result(1));
		FullAdderInst3: OnebitFullAdd
			port map (a=>a(2), b=>d(2), cin=>ca2, sum=>result(2));
		FullAdderInst4: OnebitFullAdd
			port map (a=>a(3), b=>d(3), cin=>ca3, sum=>result(3));	

end architecture;
