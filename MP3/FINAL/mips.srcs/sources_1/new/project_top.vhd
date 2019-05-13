library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity project_top is -- top-level design for testing
  port( 
       CLKM : in STD_LOGIC;
 --      A_TO_G : out STD_LOGIC_VECTOR(6 downto 0);
       AN : out STD_LOGIC_VECTOR(7 downto 0);
       DP : out STD_LOGIC;
       LED : out  STD_LOGIC_VECTOR(3 downto 0);
       reset : in STD_LOGIC;
       x : in STD_LOGIC_VECTOR(31 downto 0)
	   );
end;

architecture project_top of project_top is 
    component computer_top
        port(
            CLKM : in STD_LOGIC;
            x : in STD_LOGIC_VECTOR(31 downto 0);
          --A_TO_G : out STD_LOGIC_VECTOR(6 downto 0);
            AN : out STD_LOGIC_VECTOR(7 downto 0);
            DP : out STD_LOGIC;
            LED : out  STD_LOGIC_VECTOR(3 downto 0);
            clk_div: out STD_LOGIC_VECTOR(28 downto 0)
        );
    end component;
    
    component PmodJSTK_Demo
        port(
            CLK
        );
    end component;
    
    begin
        computer: computer_top port map(CLKM => CLKM, AN => AN, DP => DP, LED => LED, x => x );
    
end project_top;