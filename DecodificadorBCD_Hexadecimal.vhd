library ieee;
use ieee.std_logic_1164.all;

entity DecodificadorBCD_Hexadecimal is
port (
			bcd : in  STD_LOGIC_VECTOR (3 downto 0);
         hex : out STD_LOGIC_VECTOR (6 downto 0));
			  
end DecodificadorBCD_Hexadecimal;

architecture Decodificador of DecodificadorBCD_Hexadecimal is
begin
process(bcd)
    begin
        case bcd is
            when "0000" => hex <= "0000001";
            when "0001" => hex <= "1001111";
            when "0010" => hex <= "0010010";
            when "0011" => hex <= "0000110";
            when "0100" => hex <= "1001100";
            when "0101" => hex <= "0100100";
            when "0110" => hex <= "0100000";
            when "0111" => hex <= "0001111";
				when "1000" => hex <= "0000000";
				when "1001" => hex <= "0001100";
            when "1010" => hex <= "0001000";
            when "1011" => hex <= "1100000";
            when "1100" => hex <= "0110001";
            when "1101" => hex <= "1000010";
            when "1110" => hex <= "0110000";
            when "1111" => hex <= "0111000";
            
        end case;
    end process;
end architecture;

