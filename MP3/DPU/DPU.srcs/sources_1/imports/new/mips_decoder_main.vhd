
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
  port(op:                  in  STD_LOGIC_VECTOR(5 downto 0);
       memtoreg, memwrite:  out STD_LOGIC;
       branch, bne, alusrc: out STD_LOGIC;
       regdst, regwrite:    out STD_LOGIC;
       jump:                out STD_LOGIC;
       aluop:               out  STD_LOGIC_VECTOR(1 downto 0));
end;

architecture behave of maindec is
  signal controls: STD_LOGIC_VECTOR(9 downto 0);
begin
  process(op) begin
    case op is
      when "00000" => controls <= "000000000XXXXXX00X0"; -- ADD
      when "00001" => controls <= "000010001XXXXXX00X0"; -- SUB
      when "00010" => controls <= "00010XXXXXXXXXX11X1"; -- JUMP
      when "00011" => controls <= "000111010XXXXXX1011"; -- BE
      when "00100" => controls <= "001001010XXXXXX0101"; -- BNE
      when "00101" => controls <= "001010100XXXXXX00X0"; -- AND
      when "00110" => controls <= "001100100XXXXXX00X0"; -- NAND
      when "00111" => controls <= "001110101XXXXXX00X0"; -- OR
      when "01000" => controls <= "010000111XXXXXX00X0"; -- NOR
      when "01001" => controls <= "010011110XXXXXX01??"; -- BGZ
      when "01010" => controls <= "010101101XXXXXX01??"; -- BLZ
      when "01011" => controls <= "010110010XXXXXX00X0"; -- SR
      when "01100" => controls <= "011000011XXXXXX00X0"; -- SL
      when "01101" => controls <= "01101XXXXX1XXXXXXX0"; -- LW
      when "01110" => controls <= "01110XXXX1XXXXXXXX0"; -- SW
      when "01111" => controls <= "1100000100"; -- Rtype
      when "10000" => controls <= "1100000100"; -- Rtype
      when others   => controls <= "----------"; -- illegal op
    end case;
  end process;

  aluop <= controls(13 downto 9);
  memWrite <= controls(8);
  memRead <= controls(7);
  memDest <= controls(6 downto 3);
  branch <= controls(2);
  bne <= controls(1);
  pcSrc <= controls(0);
  
  
  
--  bne      <= controls(9);
--  regwrite <= controls(8);
--  regdst   <= controls(7);
--  alusrc   <= controls(6);
--  branch   <= controls(5);
--  memwrite <= controls(4);
--  memtoreg <= controls(3);
--  jump     <= controls(2);
--  aluop    <= controls(1 downto 0);
end;


