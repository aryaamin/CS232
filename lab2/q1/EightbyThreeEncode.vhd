library IEEE;
use IEEE.std_logic_1164.all;

entity EightbyThreeEncode is
port ( i : in std_logic_vector(7 downto 0);
en: in std_logic;
z : out std_logic_vector(2 downto 0));
end entity;


architecture EightbyThreeEncode_arc of EightbyThreeEncode is
	
	signal p: std_logic;
	signal q: std_logic;
	signal r: std_logic;
	signal s: std_logic;
	signal t: std_logic;
	signal u: std_logic;
	signal w1: std_logic;
	signal w2: std_logic;
	signal w3: std_logic;
	
	component mux
		port (in0,in1,sel: in std_logic; out0: out std_logic);
	end component;
	
begin
	MuxInst1: mux
		port map (in0=>i(1), in1=>i(3), sel=>i(3), out0=>p);	
	MuxInst2: mux
		port map (in0=>i(5), in1=>i(7), sel=>i(7), out0=>q);	
	MuxInst3: mux
		port map (in0=>p, in1=>q, sel=>q, out0=>w1);	
	MuxInst4: mux
		port map (in0=>i(2), in1=>i(3), sel=>i(3), out0=>r);	
	MuxInst5: mux
		port map (in0=>i(6), in1=>i(7), sel=>i(7), out0=>s);	
	MuxInst6: mux
		port map (in0=>r, in1=>s, sel=>s, out0=>w2);		
	MuxInst7: mux
		port map (in0=>i(4), in1=>i(5), sel=>i(5), out0=>t);	
	MuxInst8: mux
		port map (in0=>i(6), in1=>i(7), sel=>i(7), out0=>u);	
	MuxInst9: mux
		port map (in0=>t, in1=>u, sel=>u, out0=>w3);	
	MuxInst10: mux
		port map (in0=>en, in1=>w1, sel=>en, out0=>z(0));
	MuxInst11: mux
		port map (in0=>en, in1=>w2, sel=>en, out0=>z(1));
	MuxInst12: mux
		port map (in0=>en, in1=>w3, sel=>en, out0=>z(2));	
		
end architecture;