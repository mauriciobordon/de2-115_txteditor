LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE editor_package IS
	COMPONENT editor
		PORT (Clk50Mhz : IN STD_LOGIC;
				Reset : IN STD_LOGIC;
				wrt, spc, inc, dec : IN STD_LOGIC;
				En, RS, RW : OUT STD_LOGIC;
				Data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				displayModo : OUT STD_LOGIC_VECTOR(0 TO 6));
	END COMPONENT;
END editor_package;