library ieee;
use ieee.std_logic_1164.all;

entity xnor_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture xnor_arc of xnor_gate is

	signal p: std_logic;
	
	component not_gate
		port (a: in std_logic; b: out std_logic);
	end component;
	
	component xor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
	
	XorInst1: xor_gate
		port map (a=>a, b=>b, c=>p);
	NotInst1: not_gate
		port map (a=>p, b=>c);
end architecture;