
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY P4AdderTest IS
END P4AdderTest;
 
ARCHITECTURE behavior OF P4AdderTest IS 
 
 
    COMPONENT P4Adder
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         cin : IN  std_logic;
         S : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal cin : std_logic := '0';

   signal S : std_logic_vector(31 downto 0);

 
BEGIN
 
   uut: P4Adder PORT MAP (
          A => A,
          B => B,
          cin => cin,
          S => S
        );

   stim_proc: process
   begin		
      wait for 10 ns;	
		
		cin <= '0';
		A <= x"0000FF0E";
		B <= x"000000F0";
		wait for 10 ns;
		
		cin <= '0';
		A <= x"0000FF0E";
		B <= x"0000FFF0";
		wait for 10 ns;
		
		cin <= '1';
		A <= x"0000FF0E";
		B <= x"00FA00F0";
		wait for 10 ns;
		
		cin <= '0';
		A <= x"0000FA0E";
		B <= x"0000F0F0";
		wait for 10 ns;
		
		cin <= '1';
		A <= x"0000FFFF";
		B <= x"0000FFFF";
		wait for 10 ns;
		
		cin <= '0';
		A <= x"0000FF0E";
		B <= x"0000CAF0";
		wait for 10 ns;
		
		cin <= '0';
		A <= x"00F0FF0E";
		B <= x"00F000F0";
		wait for 10 ns;
		
		cin <= '0';
		A <= x"0F00FF0E";
		B <= x"0FF000F0";
		wait for 10 ns;

      wait;
   end process;

END;
