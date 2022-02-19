library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
port(
    ra, rb, rc, rd, re, rf, rg, rh: in std_logic_vector (7 downto 0);
    sel: in std_logic_vector (2 downto 0);
    out0: out std_logic_vector (7 downto 0));
end entity;

architecture mux_arc of mux is
begin
	with SEL select
    out0<=ra when "000",
			 rb when "001",
			 rc when "010",
			 rd when "011",
			 re when "100",
			 rf when "101",
			 rg when "110",
			 rh when "111",
          ra  when others;
end architecture;