library ieee; 
use ieee.std_logic_1164.all; 

entity carrySelectBlock is
  
  generic 	(	nBits : 		integer := 4
  			);

  port 		(   cIn   : in 		std_logic;
          		dataA : in 		std_logic_vector(nBits-1 downto 0);
          		dataB : in 		std_logic_vector(nBits-1 downto 0);
          		sum   : out 	std_logic_vector(nBits-1 downto 0)
       		);
end entity;

architecture structural of carrySelectBlock is
  
  signal s1 : std_logic_vector(nBits-1 downto 0);
  signal s2 : std_logic_vector(nBits-1 downto 0);
  
  component MUX21_GENERIC is
    
 	Generic (	NBIT 	: 			integer:= 4

 			);	
    Port 	(	A 		:	In		std_logic_vector(NBIT-1 downto 0);
				B 		:	In		std_logic_vector(NBIT-1 downto 0);
		    	SEL 	:	In		std_logic;
		   		Y 		:	Out		std_logic_vector(NBIT-1 downto 0)
		  	);
  end component;
  
  component RCA is 

	generic ( 	nBits 	:  			Integer := 4

			);
	Port 	(	A 		:	In		std_logic_vector(nBits-1 downto 0);
		        B 		:	In		std_logic_vector(nBits-1 downto 0);
        	  	Ci 		:	In		std_logic;
        	  	S 		:	Out		std_logic_vector(nBits-1 downto 0);
      		  	Co 		:	Out		std_logic);
  end component; 
  
  begin
    
    -- adder with carry input equals to 0
    rca0 : RCA 	generic map 	( 	nBits => nBits)

    			port map		(  	A => dataA,
                          			B => dataB,
                          			Ci => '0',
                          			S => s1
                        		);
    
    -- adder with carry input equals to 1                
    rca1 : rca 	generic map 	( 	nBits => nBits)

    			port map		(  	A => dataA,
                          			B => dataB,
    		                      	Ci => '1',
                          			S => s2
                        		);	
    
    -- mux to select the right sum depending on the carry input
    mux : MUX21_GENERIC 	generic map 	( 	NBIT => nBits)

    						port map		(	A => s2,
    	                              			B => s1,
        	    			                    SEL => cIn,
            	                    			Y => sum
                                			);
end architecture;

configuration cfg_carry_select_block of carrySelectBlock is
	for structural
	 for rca0 : RCA
	   use configuration work.CFG_RCA_STRUCTURAL;
	 end for;
	 for rca1 : RCA
	   use configuration work.CFG_RCA_STRUCTURAL;
	 end for;
	 for mux : MUX21_GENERIC
	   use configuration work.CFG_MUX21_GEN_BEHAVIORAL;
	 end for;
	end for;
end cfg_carry_select_block;