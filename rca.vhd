library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RCA is 
	generic (nBits :  Integer := 4);
	Port (	 A:	In	std_logic_vector(nBits-1 downto 0);
		      B:	In	std_logic_vector(nBits-1 downto 0);
        		Ci:	In	std_logic;
        		S:	Out	std_logic_vector(nBits-1 downto 0);
        		Co:	Out	std_logic);
end RCA; 

architecture STRUCTURAL of RCA is

  signal STMP : std_logic_vector(nBits-1 downto 0);
  signal CTMP : std_logic_vector(nBits downto 0);

  component FA 
    Port ( A:	In	std_logic;
	         B:	In	std_logic;
	         Ci:	In	std_logic;
	         S:	Out	std_logic;
	         Co:	Out	std_logic);
  end component; 

begin

  CTMP(0) <= Ci;
  S <= STMP;
  Co <= CTMP(nBits);
  
  ADDER1: for I in 1 to nBits generate
    FAI : FA 
	  Port Map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
  end generate;

end STRUCTURAL;


architecture BEHAVIORAL of RCA is
  
  signal s1 : std_logic_vector(nBits downto 0);
begin
  
  s1 <= (('0' & A) + ('0' & B) + ("0000" & Ci));
  --s1 <= (('0' & A) + ('0' & B));
  S <= s1(nBits-1 downto 0);
  Co <= s1(nBits);

end BEHAVIORAL;

configuration CFG_RCA_STRUCTURAL of RCA is
  for STRUCTURAL 
    for ADDER1
      for all : FA
        use configuration WORK.CFG_FA_BEHAVIORAL;
      end for;
    end for;
  end for;
end CFG_RCA_STRUCTURAL;

configuration CFG_RCA_BEHAVIORAL of RCA is
  for BEHAVIORAL 
  end for;
end CFG_RCA_BEHAVIORAL;
