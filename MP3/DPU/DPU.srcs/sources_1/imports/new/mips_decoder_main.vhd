
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
      when "000000" => controls <= "1100000100"; -- Rtype
      when "100011" => controls <= "1010010000"; -- LW
      when "101011" => controls <= "0X101X0000"; -- SW
      when "000100" => controls <= "0X010X0010"; -- BEQ
      when "000101" => controls <= "0X000X0011"; -- BNE
      when "001000" => controls <= "1010000000"; -- ADDI
      when "000010" => controls <= "0XXX0X1XX0"; -- J
      when others   => controls <= "----------"; -- illegal op
    end case;
  end process;

  bne      <= controls(9);
  regwrite <= controls(8);
  regdst   <= controls(7);
  alusrc   <= controls(6);
  branch   <= controls(5);
  memwrite <= controls(4);
  memtoreg <= controls(3);
  jump     <= controls(2);
  aluop    <= controls(1 downto 0);
end;


