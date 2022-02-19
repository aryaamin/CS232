library ieee;
use ieee.std_logic_1164.all;

entity Adder is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Adder_arc of Adder is

	signal c0: std_logic := '0';
	signal c1, c2, c3, p0, p1, p2, p3: std_logic;

	component OnebitFullAdd
		port (a,b,cin: in std_logic; sum,cout: out std_logic);
	end component;

	component xor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;

begin

		XorInst1: xor_gate
			port map (a=>a(0), b=>b(0), c=>p0);
		XorInst2: xor_gate
			port map (a=>a(1), b=>b(1), c=>p1);
		XorInst3: xor_gate
			port map (a=>a(2), b=>b(2), c=>p2);
		XorInst4: xor_gate
			port map (a=>a(3), b=>b(3), c=>p3);	

  
		c1 <= (c0 and p0) or (a(0) and b(0));
		c2 <= (c1 and p1) or (a(1) and b(1));
		c3 <= (c2 and p2) or (a(2) and b(2));
		result(4) <= (c3 and p3) or (a(3) and b(3));
		
		
		FullAdderInst1: OnebitFullAdd
			port map (a=>a(0), b=>b(0), cin=>c0, sum=>result(0));
		FullAdderInst2: OnebitFullAdd
			port map (a=>a(1), b=>b(1), cin=>c1, sum=>result(1));
		FullAdderInst3: OnebitFullAdd
			port map (a=>a(2), b=>b(2), cin=>c2, sum=>result(2));
		FullAdderInst4: OnebitFullAdd
			port map (a=>a(3), b=>b(3), cin=>c3, sum=>result(3));	

		
end architecture;
