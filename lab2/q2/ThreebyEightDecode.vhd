library IEEE;
use IEEE.STD_LOGIC_1164.aLL;

entity ThreebyEightDecode is
	port ( i : in std_logic_vector(2 downto 0);
	en: in std_logic;
	z : out std_logic_vector(7 downto 0));
end entity;

architecture ThreebyEightDecode_arc of ThreebyEightDecode is

component nand_gate is
       Port ( a, b : in STD_LOGIC;
                c : out STD_LOGIC);
end component;

signal n0,n1,n2,s0,s1,s2,s3,p0,p1,p2,p3,q0,q1,q2,q3,q4,q5,q6,q7,r0,r1,r2,r3,r4,r5,r6,r7,t0,t1,t2,t3,t4,t5,t6,t7:STD_LOGIC;

begin

U1:nand_gate PORT MaP(a=>i(2),b=>i(2),c=>n0);
U2:nand_gate PORT MaP(a=>i(1),b=>i(1),c=>n1);
U3:nand_gate PORT MaP(a=>i(0),b=>i(0),c=>n2);

U4:nand_gate PORT MaP(a=>n0,b=>n1,c=>s0);
U5:nand_gate PORT MaP(a=>n0,b=>i(1),c=>s1);
U6:nand_gate PORT MaP(a=>i(2),b=>n1,c=>s2);
U7:nand_gate PORT MaP(a=>i(2),b=>i(1),c=>s3);

U8:nand_gate PORT MaP(a=>s0,b=>s0,c=>p0);
U9:nand_gate PORT MaP(a=>s1,b=>s1,c=>p1);
U10:nand_gate PORT MaP(a=>s2,b=>s2,c=>p2);
U11:nand_gate PORT MaP(a=>s3,b=>s3,c=>p3);

U12:nand_gate PORT MaP(a=>p0,b=>n2,c=>q0);
U13:nand_gate PORT MaP(a=>p0,b=>i(0),c=>q1);
U14:nand_gate PORT MaP(a=>p1,b=>n2,c=>q2);
U15:nand_gate PORT MaP(a=>p1,b=>i(0),c=>q3);
U16:nand_gate PORT MaP(a=>p2,b=>n2,c=>q4);
U17:nand_gate PORT MaP(a=>p2,b=>i(0),c=>q5);
U18:nand_gate PORT MaP(a=>p3,b=>n2,c=>q6);
U19:nand_gate PORT MaP(a=>p3,b=>i(0),c=>q7);

U20:nand_gate PORT MaP(a=>q0,b=>q0,c=>r0);
U21:nand_gate PORT MaP(a=>q1,b=>q1,c=>r1);
U22:nand_gate PORT MaP(a=>q2,b=>q2,c=>r2);
U23:nand_gate PORT MaP(a=>q3,b=>q3,c=>r3);
U24:nand_gate PORT MaP(a=>q4,b=>q4,c=>r4);
U25:nand_gate PORT MaP(a=>q5,b=>q5,c=>r5);
U26:nand_gate PORT MaP(a=>q6,b=>q6,c=>r6);
U27:nand_gate PORT MaP(a=>q7,b=>q7,c=>r7);

U28:nand_gate PORT MaP(a=>r0,b=>en,c=>t0);
U29:nand_gate PORT MaP(a=>r1,b=>en,c=>t1);
U30:nand_gate PORT MaP(a=>r2,b=>en,c=>t2);
U31:nand_gate PORT MaP(a=>r3,b=>en,c=>t3);
U32:nand_gate PORT MaP(a=>r4,b=>en,c=>t4);
U33:nand_gate PORT MaP(a=>r5,b=>en,c=>t5);
U34:nand_gate PORT MaP(a=>r6,b=>en,c=>t6);
U35:nand_gate PORT MaP(a=>r7,b=>en,c=>t7);

U36:nand_gate PORT MaP(a=>t0,b=>t0,c=>z(0));
U37:nand_gate PORT MaP(a=>t1,b=>t1,c=>z(1));
U38:nand_gate PORT MaP(a=>t2,b=>t2,c=>z(2));
U39:nand_gate PORT MaP(a=>t3,b=>t3,c=>z(3));
U40:nand_gate PORT MaP(a=>t4,b=>t4,c=>z(4));
U41:nand_gate PORT MaP(a=>t5,b=>t5,c=>z(5));
U42:nand_gate PORT MaP(a=>t6,b=>t6,c=>z(6));
U43:nand_gate PORT MaP(a=>t7,b=>t7,c=>z(7));

end architecture;