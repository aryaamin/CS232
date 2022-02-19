library ieee;
use ieee.std_logic_1164.all;

entity FourbitALU is
port ( a, b: in std_logic_vector (3 downto 0);
sel: in std_logic_vector (2 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture FourbitALU_arc of FourbitALU is

	signal ra, rb, rc, rd, re, rf, rg, rh: std_logic_vector (7 downto 0);

	component Adder 
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component Subtractor 
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
		
	component Multiplier
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component Comparator
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component Bitwise_NAND
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component Bitwise_NOR
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component Bitwise_XOR
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component Bitwise_XNOR
		port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
	end component;
	
	component mux
		port(
    ra, rb, rc, rd, re, rf, rg, rh: in std_logic_vector (7 downto 0);
    sel: in std_logic_vector (2 downto 0);
    out0: out std_logic_vector (7 downto 0));
	end component;
	
begin

	AdderInst1: Adder
		port map(a=>a, b=>b, result=>ra);
	SubInst1: Subtractor
		port map(a=>a, b=>b, result=>rb);
	MulInst1: Multiplier
		port map(a=>a, b=>b, result=>rc);
	CompInst1: Comparator
		port map(a=>a, b=>b, result=>rd);
	NANDInst1: Bitwise_NAND
		port map(a=>a, b=>b, result=>re);
	NORInst1: Bitwise_NOR
		port map(a=>a, b=>b, result=>rf);
	XORInst1: Bitwise_XOR
		port map(a=>a, b=>b, result=>rg);
	XNORInst1: Bitwise_XNOR
		port map(a=>a, b=>b, result=>rh);
				
	MuxInst1: mux
		port map(ra=>ra, rb=>rb, rc=>rc, rd=>rd, re=>re, rf=>rf, rg=>rg, rh=>rh, sel=>sel, out0=>result);
	
		
end architecture;
