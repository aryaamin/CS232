library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
port(
    in0, in1: in std_logic;
    sel: in std_logic;
    out0: out std_logic);
end entity;

architecture mux_arc of mux is
begin
    out0<=in1 when sel='1'
    else in0;
end architecture;