library ieee;
use ieee.std_logic_1164.all;

entity xnor_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture xnor_arc of xnor_gate is

	signal p: std_logic;
	signal q: std_logic;
	signal r: std_logic;
	signal s: std_logic;
	
	component or_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
	component not_gate
		port (a: in std_logic; b: out std_logic);
	end component;
	
	component and_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
	NotInst1: not_gate
		port map (a=>a, b=>q);
	NotInst2: not_gate
		port map (a=>b, b=>r);
	AndInst1: and_gate
		port map (a=>a, b=>b, c=>p);	
	AndInst2: and_gate
		port map (a=>q, b=>r, c=>s);	
	OrInst1: or_gate
		port map (a=>p, b=>s, c=>c);
		
end architecture;
