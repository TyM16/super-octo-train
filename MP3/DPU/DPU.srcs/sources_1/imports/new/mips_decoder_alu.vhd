library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity aludec is -- ALU control decoder
  port(funct:      in  STD_LOGIC_VECTOR(5 downto 0);
       aluop:      in  STD_LOGIC_VECTOR(3 downto 0);
       alucontrol: out STD_LOGIC_VECTOR(3 downto 0));
end;

architecture behave of aludec is
begin
  process(aluop, funct) begin
    case aluop is
      when "00000" => alucontrol <= "00010"; -- add (for lb/sb/addi)
      when "00001" => alucontrol <= "00110"; -- sub (for beq)
      when "00011" => alucontrol <= "00011"; -- xori (for xori)
      when others => case funct is         -- R-type instructions
                         when "100000" => alucontrol <= "00010"; -- add (for add)
                         when "100010" => alucontrol <= "00110"; -- subtract (for sub)
                         when "100100" => alucontrol <= "00000"; -- logical and (for and)
                         when "100101" => alucontrol <= "00001"; -- logical or (for or)
                         when "101010" => alucontrol <= "00111"; -- set on less (for slt)
                         when others   => alucontrol <= "-----"; -- should never happen
                     end case;
    end case;
  end process;
end;

