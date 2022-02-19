library ieee;
use ieee.std_logic_1164.all;

entity Bitwise_NAND is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Bitwise_NAND_arc of Bitwise_NAND is

	signal and00, and11, and22, and33: std_logic;
	
	component not_gate
		port (a: in std_logic; b: out std_logic);
	end component;
	
	component and_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;

begin
	
		AndInst1: and_gate
			port map (a=>a(0), b=>b(0), c=>and00);
		AndInst2: and_gate
			port map (a=>a(1), b=>b(1), c=>and11);
		AndInst3: and_gate
			port map (a=>a(2), b=>b(2), c=>and22);
		AndInst4: and_gate
			port map (a=>a(3), b=>b(3), c=>and33);


		NotInst1: not_gate
			port map(a=>and00, b=>result(0));
		NotInst2: not_gate
			port map(a=>and11, b=>result(1));
		NotInst3: not_gate
			port map(a=>and22, b=>result(2));
		NotInst4: not_gate
			port map(a=>and33, b=>result(3));
		
end architecture;
