library ieee;
use ieee.std_logic_1164.all;

entity FourbitRipCarAdd is
port ( a, b : in std_logic_vector (3 downto 0);
cin: in std_logic;
sum : out std_logic_vector (3 downto 0);
cout: out std_logic);
end entity;

architecture FourbitRipCarAdd_arc of FourbitRipCarAdd is

	signal c0: std_logic;
	signal c1: std_logic;
	signal c2: std_logic;
	
	component OnebitFullAdd
		port (a,b,cin: in std_logic; sum,cout: out std_logic);
	end component;
	
begin
	FullAdderInst1: OnebitFullAdd
		port map (a=>a(0), b=>b(0), cin=>cin, sum=>sum(0), cout=>c0);
	FullAdderInst2: OnebitFullAdd
		port map (a=>a(1), b=>b(1), cin=>c0, sum=>sum(1), cout=>c1);
	FullAdderInst3: OnebitFullAdd
		port map (a=>a(2), b=>b(2), cin=>c1, sum=>sum(2), cout=>c2);
	FullAdderInst4: OnebitFullAdd
		port map (a=>a(3), b=>b(3), cin=>c2, sum=>sum(3), cout=>cout);	
		
end architecture;
