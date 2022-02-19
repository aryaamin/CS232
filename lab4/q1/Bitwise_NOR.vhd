library ieee;
use ieee.std_logic_1164.all;

entity Bitwise_NOR is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Bitwise_NOR_arc of Bitwise_NOR is

	signal or00, or11, or22, or33: std_logic;
	
	component or_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
	component not_gate
		port (a: in std_logic; b: out std_logic);
	end component;

begin

			OrInst1: or_gate
				port map(a=>a(0), b=>b(0), c=>or00);
			NotInst1: not_gate
				port map(a=>or00, b=>result(0));
			OrInst2: or_gate
				port map(a=>a(1), b=>b(1), c=>or11);
			NotInst2: not_gate
				port map(a=>or11, b=>result(1));
			OrInst3: or_gate
				port map(a=>a(2), b=>b(2), c=>or22);
			NotInst3: not_gate
				port map(a=>or22, b=>result(2));
			OrInst4: or_gate
				port map(a=>a(3), b=>b(3), c=>or33);
			NotInst4: not_gate
				port map(a=>or33, b=>result(3));
	
		
end architecture;
