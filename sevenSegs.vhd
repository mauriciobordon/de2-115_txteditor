LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entidade usada para converter um vetor binario para o formato do display de 7 segmentos

ENTITY sevenSegs IS
	PORT (inVec : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			out7 : OUT STD_LOGIC_VECTOR(0 TO 6));
END sevenSegs;

ARCHITECTURE logica OF sevenSegs IS
BEGIN		
WITH inVec SELECT
		out7 <= "0000001" WHEN "0000",
				  "1001111" WHEN "0001",
 				  "0010010" WHEN "0010",
				  "0000110" WHEN "0011",
				  "1001100" WHEN "0100",
				  "0100100" WHEN "0101",
				  "0100000" WHEN "0110",
				  "0001111" WHEN "0111",
				  "0000000" WHEN "1000",
				  "0000100" WHEN "1001",
				  "0001000" WHEN "1010",
				  "1100000" WHEN "1011",
				  "0110001" WHEN "1100",
				  "1000010" WHEN "1101",
				  "0110000" WHEN "1110",
				  "0111000" WHEN "1111",
				  "1111111" WHEN OTHERS;
END logica;