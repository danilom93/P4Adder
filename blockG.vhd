library ieee; 
use ieee.std_logic_1164.all; 

entity blockG is 
  
  port (  Pik : in std_logic;
          Gik : in std_logic;
          Gk_1j : in std_logic;
          Gij : out std_logic
        );
end entity;


architecture behavioral of blockG is
  
  begin
    
    Gij <= Gik or (Pik and Gk_1j);
end architecture;