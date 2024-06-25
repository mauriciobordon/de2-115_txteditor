LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

-- entidade usada para dividir um clock
-- reduz a frequencia do clock {fator} vezes

ENTITY clkDivider IS
	PORT (inClk : IN STD_LOGIC;
			outClk : OUT STD_LOGIC);
END clkDivider;

ARCHITECTURE logica OF clkDivider IS
SIGNAL conteiro : INTEGER := 0;
CONSTANT fator : INTEGER := 25000000;  -- <<< INSIRA - deve ser ao menos par ou grande
CONSTANT limite : INTEGER := fator - 1;
CONSTANT meio : INTEGER := fator / 2;
BEGIN

	PROCESS(inClk)
	BEGIN
		IF RISING_EDGE(inClk) THEN
			IF conteiro < limite THEN
				conteiro <= conteiro + 1;
			ELSE
				conteiro <= 0;
			END IF;
			IF conteiro < meio THEN
				outClk <= '0';
			ELSE
				outClk <= '1';
			END IF;
		END IF;
		
	END PROCESS;
	

END logica;