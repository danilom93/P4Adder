library ieee; 
use ieee.std_logic_1164.all; 

entity blockPG is 
  
  port (  Pik : in std_logic;
          Gik : in std_logic;
          Gk_1j : in std_logic;
          Pk_1j : in std_logic;
          Gij : out std_logic;
          Pij : out std_logic
        );
end entity;


architecture behavioral of blockPG is
  
  begin
    
    Gij <= Gik or (Pik and Gk_1j);
    Pij <= Pik and Pk_1j;
end architecture;
