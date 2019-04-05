library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity ALU_testbench is
end;

architecture ALU_testbench of ALU_testbench is
    -- component under test
    component ALU is
        generic(width: integer := 16);
        port(input_a, input_b:         in STD_LOGIC_VECTOR((width-1) downto 0);
            shift:                     in STD_LOGIC_VECTOR(3 downto 0);
            alucontrol:                in STD_LOGIC_VECTOR(3 downto 0);
            result:                    inout STD_LOGIC_VECTOR((width-1) downto 0);
            zero:                      out STD_LOGIC);
    end component;
    
    signal input_a, input_b, result:    STD_LOGIC_VECTOR(16 downto 0);
    signal shift, alucontrol:           STD_LOGIC_VECTOR(3 downto 0);
    signal zero:                        STD_LOGIC;
    
begin
    -- start input_a and input_b at 0 and increment
    input_a_proc: process begin
        input_a <= (others => '0');
        wait for 20ns;
        input_a <= input_a + '1';
        wait for 20ns;
    end process;
    
    input_b_proc: process begin
        input_b <= (others => '0');
        wait for 20ns;
        input_b <= input_b + "10";
        wait for 20ns;
        input_b <= input_b - '1';
        wait for 20ns;
    end process;
    
    shift_proc: process begin
        shift <= "0001";
    end process;
    
    alu_control_proc: process begin
        alucontrol <= "0000";
        wait for 20ns;
        alucontrol <= "0001";
        wait for 20ns;
        alucontrol <= "0010";
        wait for 20ns;
        alucontrol <= "0011";
        wait for 20ns;
        alucontrol <= "0100";
        wait for 20ns;
        alucontrol <= "0101";
        wait for 20ns;
        alucontrol <= "0110";
        wait for 20ns;
        alucontrol <= "0111";
        wait for 20ns;
        alucontrol <= "1000";
        wait for 20ns;
        alucontrol <= "1001";
        wait for 20ns;
        alucontrol <= "1010";
        wait for 20ns;
        alucontrol <= "1011";
        wait for 20ns;
        alucontrol <= "1100";
        wait for 20ns;
        alucontrol <= "1101";
        wait for 20ns;
        alucontrol <= "1110";
        wait for 20ns;
        alucontrol <= "1111";
        wait for 20ns;
    end process;
    
    -- device to test
    alu_to_test: ALU port map(
        input_a => input_a,
        input_b => input_b,
        shift => shift,
        alucontrol => alucontrol,
        result => result,
        zero => zero
    );     

end ALU_testbench;