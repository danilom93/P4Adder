library ieee;
use ieee.std_logic_1164.all;

entity MUX21_GENERIC is
	
	Generic (NBIT: integer:= 4);
				
	Port (	A:		In		std_logic_vector(NBIT-1 downto 0) ;
				B:		In		std_logic_vector(NBIT-1 downto 0);
				SEL:	In		std_logic;
				Y:		Out	std_logic_vector(NBIT-1 downto 0));

end MUX21_GENERIC;

architecture Behavioral of MUX21_GENERIC is

	begin
	
		Y <= 	A when SEL = '1' else B;

end Behavioral;

architecture Structural of MUX21_GENERIC is

	component mux_2to1 is
		Port ( sel : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           o : out  STD_LOGIC);
	end component;
	
	begin
		
		conn: for i in 0 to NBIT-1 generate 
			mu	:	mux_2to1
					port map	(	sel => sel,
									a => A(i),
									b => B(i),
									o => Y(i)
								);
	end generate;
	 
end Structural;

configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is
	for Behavioral
	end for;
end CFG_MUX21_GEN_BEHAVIORAL;

configuration CFG_MUX21_GEN_STRUCTURAL of MUX21_GENERIC is
	for Structural
	end for;
end CFG_MUX21_GEN_STRUCTURAL;

