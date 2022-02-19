library ieee;
use ieee.std_logic_1164.all;

entity OnebitHalfAdd is
port ( a, b : in std_logic;
sum, cout: out std_logic);
end entity;

architecture OnebitHalfAdd_arc of OnebitHalfAdd is

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
		port map (a=>a, b=>p);	
	NotInst2: not_gate
		port map (a=>b, b=>q);	
	OrInst1: or_gate
		port map (a=>a, b=>b, c=>r);
	ORInst2: or_gate
		port map (a=>p, b=>q, c=>s);
	AndInst1: and_gate
		port map (a=>r, b=>s, c=>sum);
	AndInst2: and_gate
		port map (a=>a, b=>b, c=>cout);
		
end architecture;