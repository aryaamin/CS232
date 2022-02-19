library ieee;
use ieee.std_logic_1164.all;

entity Bitwise_XNOR is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Bitwise_XNOR_arc of Bitwise_XNOR is
	
	component xnor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;

begin

		
			XnorInst1: xnor_gate
				port map(a=>a(0), b=>b(0), c=>result(0));
			XnorInst2: xnor_gate
				port map(a=>a(1), b=>b(1), c=>result(1));
			XnorInst3: xnor_gate
				port map(a=>a(2), b=>b(2), c=>result(2));
			XnorInst4: xnor_gate
				port map(a=>a(3), b=>b(3), c=>result(3));

end architecture;
