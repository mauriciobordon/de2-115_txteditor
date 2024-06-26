LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.editor_package.all;

--	entidade criada para fazer interface com a placa DE2-115 e possibilitar nomenclaturas mnemonicas

ENTITY placa IS
	PORT (CLOCK_50 : IN STD_LOGIC;	-- deve ser de necessariamente 50 MHz
			SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
			KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6);
			LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
			LEDG : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			
			LCD_RS : OUT STD_LOGIC;
			LCD_RW : OUT STD_LOGIC;
			LCD_DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			LCD_EN : OUT STD_LOGIC);
			
			-- HEX7: modo atual da placa
END placa;

ARCHITECTURE logica OF placa IS
BEGIN

	interface: editor PORT MAP(Clk50Mhz => CLOCK_50,
										Reset => NOT KEY(0),
										wrt => SW(0),
										spc => NOT KEY(1),
										inc => NOT KEY(2),
										dec => NOT KEY(3),
										RS => LCD_RS,
										RW => LCD_RW,
										Data => LCD_DATA,
										En => LCD_EN,
										displayModo => HEX7);
ledg(0) <= sw(0);
END logica;