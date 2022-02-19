library ieee;
use ieee.std_logic_1164.all;

entity FourbitRipCarAddSub is
port ( a, b : in std_logic_vector (3 downto 0);
cin: in std_logic;
sum : out std_logic_vector (3 downto 0);
cout: out std_logic);
end entity;

architecture FourbitRipCarAddSub_arc of FourbitRipCarAddSub is

	signal d: std_logic_vector (3 downto 0);
	
	component FourbitRipCarAdd
		port ( a, b : in std_logic_vector (3 downto 0);
				 cin: in std_logic;
				 sum : out std_logic_vector (3 downto 0);
				 cout: out std_logic);
	end component;
	
	component xor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
	XorInst1: xor_gate
		port map (a=>cin, b=>b(0), c=>d(0));
	XorInst2: xor_gate
		port map (a=>cin, b=>b(1), c=>d(1));
	XorInst3: xor_gate
		port map (a=>cin, b=>b(2), c=>d(2));
	XorInst4: xor_gate
		port map (a=>cin, b=>b(3), c=>d(3));	
	FourbitRipCarAddInst1: FourbitRipCarAdd
		port map (a=>a, b=>d, cin=>cin, sum=>sum, cout=>cout);
		
end architecture;


library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture xor_arc of xor_gate is

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
		port map (a=>r, b=>s, c=>c);
		
end architecture;
