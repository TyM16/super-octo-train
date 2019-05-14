
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
  port(op:                               in  STD_LOGIC_VECTOR(5 downto 0);
       memtoreg, memwrite, memread:      out STD_LOGIC; -- we may not need mem to reg it may be 
       branch, bne, alusrc:              out STD_LOGIC;
       regdest:                          out STD_LOGIC_VECTOR(3 downto 0);
       regwrite:                         out STD_LOGIC;
       jump:                             out STD_LOGIC;
       pcsrc:                            out STD_LOGIC;
       aluop:                            out  STD_LOGIC_VECTOR(3 downto 0));
end;

architecture behave of maindec is
  signal controls: STD_LOGIC_VECTOR(19 downto 0);
begin
  process(op) begin
    case op is
      when "000000" => controls <= "0000000000XXXXXX00X0"; -- ADD
      when "000001" => controls <= "0000010001XXXXXX00X0"; -- SUB
      when "000010" => controls <= "000010XXXXXXXXXX11X1"; -- JUMP
      when "000011" => controls <= "0000111010XXXXXX1011"; -- BE
      when "000100" => controls <= "0001001010XXXXXX0101"; -- BNE
      when "000101" => controls <= "0001010100XXXXXX00X0"; -- AND
      when "000110" => controls <= "0001100100XXXXXX00X0"; -- NAND
      when "000111" => controls <= "0001110101XXXXXX00X0"; -- OR
      when "001000" => controls <= "0010000111XXXXXX00X0"; -- NOR
      when "001001" => controls <= "0010011110XXXXXX01XX"; -- BGZ
      when "001010" => controls <= "0010101101XXXXXX01XX"; -- BLZ
      when "001011" => controls <= "0010110010XXXXXX00X0"; -- SR
      when "001100" => controls <= "0011000011XXXXXXXXX0"; -- SL
      when "001101" => controls <= "001101XXXXX1XXXXXXX0"; -- LW
      when "001110" => controls <= "001110XXXX1XXXXXXXX0"; -- SW
      when "001111" => controls <= "0011111010X1XXXX0000"; -- EQ
      when "010000" => controls <= "0100001011X1XXXX00X0"; -- NLE
      when "010001" => controls <= "0100011100X1XXXX00X0"; -- NGE
      when "010010" => controls <= "0100101101X1XXXX00X0"; -- LT
      when "010011" => controls <= "0100111110X1XXXX00X0"; -- GT
      when others  => controls <= "--------------------"; -- illegal op
    end case;
  end process;
  
  bne      <= controls(2);
  branch   <= controls(3);
  regdest  <= controls(7 downto 4);
  memread  <= controls(8);
  memwrite <= controls(9);
  pcsrc    <= controls(0);
  aluop    <= controls(17 downto 14); -- send this directly to ALU
end;


