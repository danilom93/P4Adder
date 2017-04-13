library ieee; 
use ieee.std_logic_1164.all; 
use work.functions.all;

entity sparseTree is
  
	generic (	nBits : integer := 32; 
					step 	: integer := 4	
				);
				
	port ( 	A 		: in std_logic_vector(nBits-1 downto 0);
				B 		: in std_logic_vector(nBits-1 downto 0);
				cin 	: in std_logic;
				cout 	: out std_logic_vector(nBits/step-1 downto 0)
        );
		  
end entity;

architecture structural of sparseTree is
  
	constant nRow : integer := log2(nBits) + 1;
	type mySignal_t is array (nRow-1 downto 0) of std_logic_vector(nBits-1 downto 0); 
	signal pSignal, gSignal: mySignal_t;
	
	component pgNetwork is
		
		generic (nBits : integer := 32);
		port ( 	A : in std_logic_vector(nBits-1 downto 0);
					B : in std_logic_vector(nBits-1 downto 0);
					cin : in std_logic;
					P : out std_logic_vector(nBits-1 downto 0);
					G : out std_logic_vector(nBits-1 downto 0)
				);
	end component;
  
	component blockPG is 
  
		port (  	Pik : in std_logic;
					Gik : in std_logic;
					Gk_1j : in std_logic;
					Pk_1j : in std_logic;
					Gij : out std_logic;
					Pij : out std_logic
				);
	end component;
  
  component blockG is 
  
		port (  	Pik : in std_logic;
					Gik : in std_logic;
					Gk_1j : in std_logic;
					Gij : out std_logic
				);
	end component; 

	begin
    
		m_pgNetwork : pgNetwork generic map (	nBits 	=> nBits)
										port map 	( 	A		 	=> A,
															B 			=> B,
															cin		=> cin,
															P 			=> pSignal(0),
															G 			=> gSignal(0)
														);
													
	G0: for l in 1 to nRow-1 generate
	
		G1: for i in 0 to nBits-1 generate
			
			G2: if (l <= log2(step)) generate
			
				G3: if ((i+1)mod(2**l) = 0) generate
				
					G4: if (i < 2**l) generate
					
						m_blockG : blockG	port map(  	Pik 		=> pSignal(l-1)(i),
																Gik 		=> gSignal(l-1)(i),
																Gk_1j 	=> gSignal(l-1)(i - 2**(l-1)),
																Gij 		=> gSignal(l)(i)
															);

					end generate;
					
					G5: if (i >= 2**l) generate
					
						m_blockPG : blockPG	port map(  	Pik 		=> pSignal(l-1)(i),
																	Gik 		=> gSignal(l-1)(i),
																	Gk_1j 	=> gSignal(l-1)(i - (2**(l-1))),
																	Pk_1j		=>	pSignal(l-1)(i - (2**(l-1))),
																	Gij 		=> gSignal(l)(i),
																	Pij 		=> pSignal(l)(i)
																);

					end generate;
					
				end generate;
			end generate;
			
			G6: if (l > log2(step)) generate
			
				G7: if((i mod (2**l))>=2**(l-1) and (i mod (2**l))<2**l) and (((i+1) mod step) =0) generate
				
					G8: if (i < 2**l) generate
						
						m1_blockG : blockG	port map(  	Pik 		=> pSignal(l-1)(i),
																	Gik 		=> gSignal(l-1)(i),
																	Gk_1j 	=> gSignal(l-1)((i/2**(l-1))*2**(l-1) - 1),
																	Gij 		=> gSignal(l)(i)
															);
															
					end generate;
					
					G9: if (i>=2**l) generate
						
						m1_blockPG : blockPG	port map(  	Pik 		=> pSignal(l-1)(i),
																	Gik 		=> gSignal(l-1)(i),
																	Gk_1j 	=> gSignal(l-1)((i/2**(l-1))*2**(l-1)-1),
																	Pk_1j		=>	pSignal(l-1)((i/2**(l-1))*2**(l-1)-1),
																	Gij 		=> gSignal(l)(i),
																	Pij 		=> pSignal(l)(i)
																);
																
					end generate;
				end generate;
				
				G10: if((i mod (2**l))<2**(l-1) and (i mod (2**l))>=0) and (((i+1) mod step) =0) generate
					
					pSignal(l)(i) <= pSignal(l-1)(i);
					gSignal(l)(i) <= gSignal(l-1)(i);
				end generate;
			end generate;
			
			G11: if l = nRow-1 generate
				
				G12: if ((i+1) mod step) = 0 generate
				
					cout(i/step) <= gSignal(l)(i);
				end generate;
			end generate;
		end generate;
	end generate;
    
end architecture;      

configuration cfg_sparseTree of sparseTree is
  for structural
    for m_pgNetwork : pgNetwork
      use configuration work.cfg_pgNetwork;
    end for;
  end for;
end configuration;