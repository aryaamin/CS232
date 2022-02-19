library ieee;
use ieee.std_logic_1164.all;

entity Multiplier is
port ( a, b: in std_logic_vector (3 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture Multiplier_arc of Multiplier is

	signal and00, and01, and02, and03, and10, and11, and12, and13, and20, and21, and22, and23, and30, and31, and32, and33: std_logic;
	signal has1, has2, has3, has4, hac1, hac2, hac3, hac4: std_logic;
	signal fas1, fas2, fas3, fas4, fas5, fas6, fas7, fas8, fac1, fac2, fac3, fac4, fac5, fac6, fac7, fac8: std_logic;
	

	component OnebitFullAdd
		port (a,b,cin: in std_logic; sum,cout: out std_logic);
	end component;
	
	component OnebitHalfAdd
		port (a,b: in std_logic; sum,cout: out std_logic);
	end component;
	
	component and_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;

begin

		
		AndInst1: and_gate
			port map (a=>a(0), b=>b(0), c=>and00);
		AndInst2: and_gate
			port map (a=>a(0), b=>b(1), c=>and01);
		AndInst3: and_gate
			port map (a=>a(0), b=>b(2), c=>and02);
		AndInst4: and_gate
			port map (a=>a(0), b=>b(3), c=>and03);
		AndInst5: and_gate
			port map (a=>a(1), b=>b(0), c=>and10);
		AndInst6: and_gate
			port map (a=>a(1), b=>b(1), c=>and11);
		AndInst7: and_gate
			port map (a=>a(1), b=>b(2), c=>and12);
		AndInst8: and_gate
			port map (a=>a(1), b=>b(3), c=>and13);
		AndInst9: and_gate
			port map (a=>a(2), b=>b(0), c=>and20);
		AndInst10: and_gate
			port map (a=>a(2), b=>b(1), c=>and21);
		AndInst11: and_gate
			port map (a=>a(2), b=>b(2), c=>and22);
		AndInst12: and_gate
			port map (a=>a(2), b=>b(3), c=>and23);
		AndInst13: and_gate
			port map (a=>a(3), b=>b(0), c=>and30);
		AndInst14: and_gate
			port map (a=>a(3), b=>b(1), c=>and31);
		AndInst15: and_gate
			port map (a=>a(3), b=>b(2), c=>and32);
		AndInst16: and_gate
			port map (a=>a(3), b=>b(3), c=>and33);		
		HalfAdderInst1: OnebitHalfAdd
			port map (a=>and10, b=>and01 , sum=>has1 , cout=>hac1);	
		FullAdderInst1: OnebitFullAdd
			port map (a=>and20, b=>and11, cin=>hac1, sum=>fas1, cout=>fac1);		
		FullAdderInst2: OnebitFullAdd
			port map (a=>and30, b=>and21, cin=>fac1, sum=>fas2, cout=>fac2);		
		HalfAdderInst2: OnebitHalfAdd
			port map (a=>and31, b=>fac2 , sum=>has2 , cout=>hac2);		
		HalfAdderInst3: OnebitHalfAdd
			port map (a=>and02, b=>fas1 , sum=>has3 , cout=>hac3);
		FullAdderInst3: OnebitFullAdd
			port map (a=>fas2, b=>and12, cin=>hac3, sum=>fas3, cout=>fac3);
		FullAdderInst4: OnebitFullAdd
			port map (a=>has2, b=>and22, cin=>fac3, sum=>fas4, cout=>fac4);
		FullAdderInst5: OnebitFullAdd
			port map (a=>and32, b=>hac2, cin=>fac4, sum=>fas5, cout=>fac5);		
		HalfAdderInst4: OnebitHalfAdd
			port map (a=>and03, b=>fas3 , sum=>has4 , cout=>hac4);	
		FullAdderInst6: OnebitFullAdd
			port map (a=>and13, b=>fas4, cin=>hac4, sum=>fas6, cout=>fac6);
		FullAdderInst7: OnebitFullAdd
			port map (a=>and23, b=>fas5, cin=>fac6, sum=>fas7, cout=>fac7);
		FullAdderInst8: OnebitFullAdd
			port map (a=>and33, b=>fac5, cin=>fac7, sum=>fas8, cout=>fac8);
  
		result(0) <= and00;
		result(1) <= has1;
		result(2) <= has3;
		result(3) <= has4;
		result(4) <= fas6;
		result(5) <= fas7;
		result(6) <= fas8;
		result(7) <= fac8;
		
end architecture;
