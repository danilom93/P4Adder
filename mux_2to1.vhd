library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
    
    Port ( sel 	: in  STD_LOGIC;
           a 	: in  STD_LOGIC;
           b 	: in  STD_LOGIC;
           o 	: out STD_LOGIC);
end mux_2to1;

architecture Structural of mux_2to1 is

begin

	o <= (a and sel) or (b and not(sel));
end Structural;

