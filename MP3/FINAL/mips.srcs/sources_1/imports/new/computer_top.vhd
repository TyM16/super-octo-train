----------------------------------------------------------
-- mips computer wired to hexadecimal display and reset 
-- button
---------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity computer_top is -- top-level design for testing
  port( 
       CLKM : in STD_LOGIC;
       A_TO_G : inout STD_LOGIC_VECTOR(6 downto 0);
       AN : out STD_LOGIC_VECTOR(3 downto 0);
       DP : out STD_LOGIC;
       LED : out  STD_LOGIC_VECTOR(6 downto 0);
       reset : in STD_LOGIC;
       MISO : in STD_LOGIC;   -- Master In Slave Out, Pin 3, Port JA
       SW : in STD_LOGIC_VECTOR( 2 downto 0); -- Switches 2, 1, and 0
       SS : out STD_LOGIC;    -- Slave Select, Pin 1, Port JA
       MOSI : out STD_LOGIC;  -- Master Out Slave In, Pin 2, Port JA
       SCLK : out STD_LOGIC;  -- Serial Clock, Pin 4, Port JA
       hsync, vsync: out  std_logic;
       red: out std_logic_vector(3 downto 0);
       green: out std_logic_vector(3 downto 0);
       blue: out std_logic_vector(3 downto 0) 
  );
end;




---------------------------------------------------------
-- Architecture Definitions
---------------------------------------------------------

architecture computer_top of computer_top is
    component bouncing_box
    port(
        clk, reset, BTNL, BTNR, BTNU, BTND: in std_logic;
        hsync, vsync: out  std_logic;
        red: out std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        blue: out std_logic_vector(3 downto 0) 
    );
    end component;
  
  component PmodJSTK_Demo
   port (
      CLK : in STD_LOGIC;   -- 100Mhz onboard clock
      RST  : in STD_LOGIC;   -- Button D
      MISO : in STD_LOGIC;   -- Master In Slave Out, Pin 3, Port JA
      SW : in STD_LOGIC_VECTOR( 2 downto 0); -- Switches 2, 1, and 0
      SS : out STD_LOGIC;    -- Slave Select, Pin 1, Port JA
      MOSI : out STD_LOGIC;  -- Master Out Slave In, Pin 2, Port JA
      SCLK : out STD_LOGIC;  -- Serial Clock, Pin 4, Port JA
      LED : out STD_LOGIC_VECTOR( 2 downto 0 );  -- LEDs 2, 1, and 0
      AN: out STD_LOGIC_VECTOR( 3 downto 0 );             -- Anodes for Seven Segment Display
      SEG : out STD_LOGIC_VECTOR( 6 downto 0 )  -- Cathodes for Seven Segment Display
   );
  end component;

  component mips_top  -- top-level design for testing
    port( 
         clk : in STD_LOGIC;
         reset: in STD_LOGIC;
         out_port_1 : out STD_LOGIC_VECTOR(31 downto 0)
         );
  end component;
  
  -- this is a slowed signal clock provided to the mips_top
  -- set it from a lower bit on clk_div for a faster clock
  signal clk : STD_LOGIC := '0';
  
  -- clk_div is a 29 bit counter provided by the display hex 
  -- use bits from this to provide a slowed clock
  signal clk_div : STD_LOGIC_VECTOR(28 downto 0);

  -- this data bus will hold a value for display by the 
  -- hex display  
  signal display_bus: STD_LOGIC_VECTOR(31 downto 0); 
  
  signal res: STD_LOGIC;
  
  signal direction: STD_LOGIC_VECTOR(3 downto 0);       
  
  begin
      -- wire up slow clock 
      clk <= clk_div(27); -- use a lower bit for a faster clock
      -- clk <= clk_div(0);  -- use this in simulation (fast clk)
           
	  -- wire up the processor and memories
	  mips1: mips_top port map( clk => CLKM, reset => reset, out_port_1 => display_bus );
	  
	  direction <= A_TO_G(3 downto 0);
	  
	  --vga
	  vga: bouncing_box port map(
	       clk => CLKM,
	       reset => res,
	       BTNL => direction(0),
	       BTNR => direction(1),
	       BTNU => direction(2),
	       BTND => direction(3),
           hsync => hsync,
           vsync => vsync,
           red => red,
           green => green,
           blue => blue 
	  );
	  
	  --reset for joystick
	  res <= not reset;
	  
	  -- joystick port map
	  joystick: PmodJSTK_Demo port map(
	  
	        CLK => CLKM, 
            RST => res,
            MISO => MISO,
            SW => SW,
            SS => SS,
            MOSI => MOSI,
            SCLK => SCLK,
            LED => LED( 6 downto 4 ),
            AN => AN,
            SEG => A_TO_G
	  
	   );
	                                       
	  -- display: display_hex port map( CLKM  => CLKM,  x => display_bus, 
	  --         A_TO_G => A_TO_G,  AN => AN,  DP => DP,  LED => LED(3 downto 0), clk_div => clk_div );                                      
	  
  end computer_top;
