library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

entity Testbench is
end entity;

architecture Behave of Testbench is 
	component rlencoding is
		port(clk, rst : in std_logic; x : in std_logic_vector (7 downto 0); y : out std_logic_vector (7 downto 0); df : out std_logic);
	end component;
	
  signal input_vector  : std_logic_vector(7 downto 0);
  signal clk, rst : std_logic;
  signal output_vector : std_logic_vector(7 downto 0);
  signal data_valid : std_logic;
  
  function to_bit_vector(x: std_logic_vector) return bit_vector is
     alias lx: std_logic_vector(1 to x'length) is x;
     variable ret_val: bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_bit_vector;
  
  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
     alias lx: bit_vector(1 to x'length) is x;
     variable ret_val: std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_std_logic_vector;
  
begin
	dut_instance: rlencoding 
		port map (clk => clk, rst=> rst, x=>input_vector, y=>output_vector, df=>data_valid);
		
	process
		variable err_flag : boolean := false;
		File INFILE: text open read_mode is "/home/arya/SEM4/CS232/input.txt";
		File OUTFILE: text open write_mode is "/home/arya/SEM4/CS232/output.txt";
		
		variable input_vector_var: bit_vector (7 downto 0);
		variable output_vector_var: bit_vector (7 downto 0);
		
		variable INPUT_LINE: Line;
		variable OUTPUT_LINE: Line;
		
		variable bof : std_logic := '1';		
		variable clock, reset : std_logic := '1';
		variable count : unsigned(8 downto 0) := "000000000";
	begin
		L1 : loop 
		
			if bof = '1' then
				reset := '1';
				bof := '0';
			else
				reset := '0';
			end if;
		
			clock := '0';
				if reset = '0' then
					if count < 64 then
						report "count" & integer'image(to_integer(count));
						readLine(INFILE, INPUT_LINE);
							read(INPUT_LINE, input_vector_var);
						count := count + 1;
					end if;	
					if count = 64 then
						count := count + 1;
						input_vector_var := "11111111";
					end if;
					input_vector <= to_std_logic_vector(input_vector_var);
				else
					input_vector <= "00000000";
				end if;
				rst <= reset;
				clk <= clock;
			wait for 5 ns;
			
			clock := '1';
				clk <= clock;				
			wait for 5 ns;
			
			if data_valid = '1' then		 
				write(OUTPUT_LINE, to_bit_vector(output_vector));
				writeline(OUTFILE, OUTPUT_LINE);			
			end if;
			
		end loop;
		wait;
	end process;
	
end architecture;