
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
  signal controls: STD_LOGIC_VECTOR(18 downto 0);
begin
  process(op) begin
    case op is
      when "000000" => controls <= "000000000XXXXXX00X0"; -- ADD
      when "000001" => controls <= "000010001XXXXXX00X0"; -- SUB
      when "000010" => controls <= "00010XXXXXXXXXX11X1"; -- JUMP
      when "000011" => controls <= "000111010XXXXXX1011"; -- BE
      when "000100" => controls <= "001001010XXXXXX0101"; -- BNE
      when "000101" => controls <= "001010100XXXXXX00X0"; -- AND
      when "000110" => controls <= "001100100XXXXXX00X0"; -- NAND
      when "000111" => controls <= "001110101XXXXXX00X0"; -- OR
      when "001000" => controls <= "010000111XXXXXX00X0"; -- NOR
      when "001001" => controls <= "010011110XXXXXX01XX"; -- BGZ
      when "001010" => controls <= "010101101XXXXXX01XX"; -- BLZ
      when "001011" => controls <= "010110010XXXXXX00X0"; -- SR
      when "001100" => controls <= "011000011XXXXXXXXX0"; -- SL
      when "001101" => controls <= "01101XXXXX1XXXXXXX0"; -- LW
      when "001110" => controls <= "01110XXXX1XXXXXXXX0"; -- SW
      when "001111" => controls <= "011111010X1XXXX0000"; -- EQ
      when "010000" => controls <= "100001011X1XXXX00X0"; -- NLE
      when "010001" => controls <= "100011100X1XXXX00X0"; -- NGE
      when "010010" => controls <= "100101101X1XXXX00X0"; -- LT
      when "010011" => controls <= "100111110X1XXXX00X0"; -- GT
      when others  => controls <= "-------------------"; -- illegal op
    end case;
  end process;
  
  bne      <= controls(2);
  branch   <= controls(3);
  regdest  <= controls(7 downto 4);
  memread  <= controls(8);
  memwrite <= controls(9);
  jump     <= controls(0);
  pcsrc    <= controls(3);
  aluop    <= controls(13 downto 10); -- send this directly to ALU
end;


