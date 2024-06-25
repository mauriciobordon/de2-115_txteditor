LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE editorTools_package IS
	COMPONENT clkDivider
		PORT (inClk : IN STD_LOGIC;
				outClk : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT sevenSegs IS
		PORT (inVec : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				out7 : OUT STD_LOGIC_VECTOR (0 TO 6));
	END COMPONENT;
END editorTools_package;