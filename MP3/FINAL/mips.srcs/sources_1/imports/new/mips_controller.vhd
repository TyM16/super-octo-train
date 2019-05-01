library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

entity controller is -- single cycle control decoder
  port(input_a, input_b:   in STD_LOGIC_VECTOR(15 downto 0);
       shift:              in STD_LOGIC_VECTOR(3 downto 0);
       op, funct:          in  STD_LOGIC_VECTOR(5 downto 0);
       zero:               out  STD_LOGIC;
       memtoreg, memwrite: out STD_LOGIC;
       pcsrc, alusrc:      out STD_LOGIC;
       result:             inout STD_LOGIC_VECTOR(15 downto 0);
       regdst:             out STD_LOGIC_VECTOR(3 downto 0);
       regwrite:           out STD_LOGIC;
       jump:               out STD_LOGIC;
       alucontrol:         in STD_LOGIC_VECTOR(3 downto 0));
end;

architecture struct of controller is
  component maindec
    port(op:                               in  STD_LOGIC_VECTOR(5 downto 0);
         memtoreg, memwrite, memread:      out STD_LOGIC; -- we may not need mem to reg it may be 
         branch, bne, alusrc:              out STD_LOGIC;
         regdest:                          out STD_LOGIC_VECTOR(3 downto 0);
         regwrite:                         out STD_LOGIC;
         jump:                             out STD_LOGIC;
         aluop:                            out  STD_LOGIC_VECTOR(3 downto 0));
  end component;
  component ALU
    generic(width: integer := 16);
     port(input_a, input_b:  in STD_LOGIC_VECTOR((width-1) downto 0);
         shift:              in STD_LOGIC_VECTOR(3 downto 0);
         alucontrol:         in STD_LOGIC_VECTOR(3 downto 0);
         result:             inout STD_LOGIC_VECTOR((width-1) downto 0);
         zero:               out STD_LOGIC);
   end component;
--  component aludec
--    port(funct:      in  STD_LOGIC_VECTOR(5 downto 0);
--         aluop:      in  STD_LOGIC_VECTOR(1 downto 0);
--         alucontrol: out STD_LOGIC_VECTOR(2 downto 0));
--  end component;

  signal aluop: STD_LOGIC_VECTOR(3 downto 0);
  signal branch: STD_LOGIC;
begin
  md: maindec port map( op => op, memtoreg => memtoreg, memwrite => memwrite, branch => branch,
                       alusrc => alusrc, regdest => regdst, regwrite => regwrite, jump => jump, aluop => aluop);
--  ad: aludec port map(funct => funct, aluop => aluop, alucontrol => alucontrol);

  alu_p: ALU port map( input_a => input_a, input_b => input_b, shift => shift, alucontrol => alucontrol, result => result, zero => zero );
end;


