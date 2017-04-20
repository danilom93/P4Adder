library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity P4Adder is
	
	Generic (	nBits 	: 		integer := 32;
				step 	: 		integer := 4
			);

   	Port 	( 	A 		: in  	STD_LOGIC_VECTOR (nBits-1 downto 0);
          		B 		: in  	STD_LOGIC_VECTOR (nBits-1 downto 0);
          		cin 	: in  	STD_LOGIC;
          		S 		: out 	STD_LOGIC_VECTOR (nBits-1 downto 0)
			);
end P4Adder;

architecture Structural of P4Adder is

	signal carries : std_logic_vector(nBits/step-1 downto 0);
	signal tmp : std_logic_vector(nBits/step downto 0);
	
	component sparseTree is
  
		generic (	nBits : integer := 32; 
					step 	: integer := 4	
				);
				
		port 	( 	A 		: in std_logic_vector(nBits-1 downto 0);
					B 		: in std_logic_vector(nBits-1 downto 0);
					cin 	: in std_logic;
					cout 	: out std_logic_vector(nBits/step-1 downto 0)
				);
		  
	end component;
	
	component carrySelect is
  
		generic (	nBits : integer := 32;
					step : integer := 4
				);
		port 	(  	A : in std_logic_vector(nBits-1 downto 0);
					B : in std_logic_vector(nBits-1 downto 0);
					cIn : in std_logic_vector(nBits/step downto 0);
					S : out std_logic_vector(nBits-1 downto 0)
				);
	end component;

begin

  	tmp <= carries & cin; 

  	-- I put together the sparse tree and the carry select
	
	m_carrySelect : carrySelect 	generic map (	nBits => nBits,
													step => step
												)
									port map 	( 	A => A,
													B => B,
													cIn => tmp,
													S => S
												);
	
	m_sparseTree : sparseTree 		generic map (	nBits => nBits,
													step => step
												)
									port map 	( 	A => A,
													B => B,
													cin => cin,
													cout => carries
												);

end architecture;

