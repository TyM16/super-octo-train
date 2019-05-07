---------------------
-- ALU.vhd
-- Michael, Utsal, Tyler
-- MP2
-- 4/5/2019
---------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity ALU is
    generic(width: integer := 32);
    port(input_a, input_b:  in STD_LOGIC_VECTOR((width-1) downto 0);
        --shift:              in STD_LOGIC_VECTOR(3 downto 0);
        alucontrol:         in STD_LOGIC_VECTOR(3 downto 0);
        result:             inout STD_LOGIC_VECTOR((width-1) downto 0);
        zero:               out STD_LOGIC);
end ALU;

-- components for shifting bits
architecture Behavioral of ALU is
   component ShiftLeft is
   generic ( N : integer := 32 );
        Port (    a : in  STD_LOGIC_VECTOR(N-1 downto 0);
            --shamt : in STD_LOGIC_VECTOR(integer(ceil(log2(real(N))))-2 downto 0); -- Replaced with -2 in all instances of shamt declaration
                c : out  STD_LOGIC_VECTOR(N-1 downto 0) );
    end component ShiftLeft;

    component ShiftRight is
       generic ( N : integer := 32 );
       Port (    a : in  STD_LOGIC_VECTOR(N-1 downto 0);
	         --shamt : in STD_LOGIC_VECTOR(integer(ceil(log2(real(N))))-2 downto 0);
                 c : out  STD_LOGIC_VECTOR(N-1 downto 0) );
    end component ShiftRight;

    -- signals to store results
    signal b2, sum, sub, sl, sr, slt, le, ge, eq, nle, nge, lt, gt: STD_LOGIC_VECTOR((width-1) downto 0);
    signal const_zero: STD_LOGIC_VECTOR((width-1) downto 0) := (others => '0');

begin
  -- hardware for ALU operations
      -- hardware inverter for 2's complement 
      b2 <= not input_b when alucontrol(2) = '1' else input_b;
      
      -- hardware adder
      sum <= input_a + b2 + alucontrol(2);
      
      -- subtraction
      sub <= input_a - input_b;
      
      -- shift left
      shifter_l: ShiftLeft generic map (N => 32) port map(a=>input_a, c => sl);
      
      -- shift right
      shifter_r: ShiftRight generic map (N => 32) port map(a=>input_a, c => sr);
      
      -- less than or equal
      le <= (width-1 downto 1 => '0')&"1" when (input_a <= input_b) else (others => '0');
      
      -- greater than or equal
      ge <= (width-1 downto 1 => '0')&"1" when (input_a >= input_b) else (others => '0');
      
      -- equal
      eq <= (width-1 downto 1 => '0')&"1" when (sub = (width-1 downto 0 => '0') ) else (others => '0');
      
      -- less than or equal
      lt <= (width-1 downto 1 => '0')&"1" when (input_a < input_b) else (others => '0');
           
      -- greater than or equal
      gt <= (width-1 downto 1 => '0')&"1" when (input_a > input_b) else (others => '0');
          
      -- determine alu operation from alucontrol bits 0 and 1
      with alucontrol(3 downto 0) select result <=
        sum                  when "0000", -- add
        sub                  when "0001", -- subtract
        sr                   when "0010", -- shift right
        sl                   when "0011", -- shift left
        input_a and input_b  when "0100", -- AND
        input_a or input_b   when "0101", -- OR
        input_a xor input_b  when "0110", -- XOR
        input_a nor input_b  when "0111", -- NOR
        le                   when "1000", -- <=
        ge                   when "1001", -- >=
        eq                   when "1010", -- =
        not(le)              when "1011", -- !<=
        not(ge)              when "1100", -- !>=
        lt                   when "1101", -- <
        gt                   when "1110", -- >
        slt     when others;
            
      -- set the zero flag if result is 0
      zero <= '1' when result = const_zero else '0';


end Behavioral;