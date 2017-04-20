library ieee; 
use ieee.std_logic_1164.all; 

entity pgNetwork is
  
  generic (nBits : integer := 32);
  port (  A : in std_logic_vector(nBits-1 downto 0);
          B : in std_logic_vector(nBits-1 downto 0);
			 cin : in std_logic;
          P : out std_logic_vector(nBits-1 downto 0);
          G : out std_logic_vector(nBits-1 downto 0)
        );
        
end entity;

architecture behavioral of pgNetwork is
  
  begin 
    
    proc : process (A, B) begin
  
      for i in 0 to nBits-1 loop
			
		  if ( i = 0 ) then		
			 
        --if it is the first p g I have to take into account the carry input
        P(i) <= a(i) xor b(i);
			  G(i) <= (a(i) and b(i)) or (a(i) and cin) or (b(i) and cin);
			else
      
			 --generate the p g network
				P(i) <= A(i) xor B(i);
				G(i) <= A(i) and B(i);
			end if;
			
      end loop;
    end process;    
end architecture;

configuration cfg_pgNetwork of pgNetwork is
  
  for behavioral 
  end for;
end configuration;