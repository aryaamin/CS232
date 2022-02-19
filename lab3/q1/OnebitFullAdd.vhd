library ieee;
use ieee.std_logic_1164.all;

entity OnebitFullAdd is
port ( a, b, cin : in std_logic;
sum, cout: out std_logic);
end entity;

architecture OnebitFullAdd_arc of OnebitFullAdd is

	signal p: std_logic;
	signal q: std_logic;
	signal r: std_logic;
	signal s: std_logic;
	
	component or_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
	component OnebitHalfAdd
		port (a,b: in std_logic; sum,cout: out std_logic);
	end component;
	
begin
	HalfAdderInst1: OnebitHalfAdd
		port map (a=>a, b=>b, sum=>p, cout=>q);
	HalfAdderInst2: OnebitHalfAdd
		port map (a=>p, b=>cin, sum=>sum, cout=>r);		
	OrInst1: or_gate
		port map (a=>q, b=>r, c=>cout);
		
end architecture;
