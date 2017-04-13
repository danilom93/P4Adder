library ieee; 
use ieee.std_logic_1164.all; 

entity carrySelect is
  
  generic (	nBits : integer := 32;
				step : integer := 4
				);
  port (  A : in std_logic_vector(nBits-1 downto 0);
          B : in std_logic_vector(nBits-1 downto 0);
          cIn : in std_logic_vector(nBits/step downto 0);
          S : out std_logic_vector(nBits-1 downto 0)
        );
end entity;

architecture structural of carrySelect is
  
  component carrySelectBlock is
  
    port(   cIn   : in std_logic;
            dataA  : in std_logic_vector(3 downto 0);
            dataB  : in std_logic_vector(3 downto 0);
            sum   : out std_logic_vector(3 downto 0)
        );  
  end component;
    
  begin
    
    conn : for i in 4 to nBits generate
      
      lb : if ( i mod 4) = 0 generate 
      
        csb : carrySelectBlock port map ( cIn => cIn(i/4 - 1),
                                          dataA => A( i-1 downto i-4),
                                          dataB => B( i-1 downto i-4),
                                          sum => S( i-1 downto i-4)
                                        );
      end generate;
    end generate;
    
end architecture;

configuration cfg_carry_select of carrySelect is
	for structural
	 for conn
      for all : carrySelectBlock
        use configuration WORK.cfg_carry_select_block;
      end for;
    end for;
	end for;
end cfg_carry_select;