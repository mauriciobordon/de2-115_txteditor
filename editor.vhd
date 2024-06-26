LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.editorTools_package.all;

ENTITY editor IS
	PORT (Clk50Mhz : IN STD_LOGIC;
			Reset : IN STD_LOGIC;
			En, RS, RW : OUT STD_LOGIC;
			Data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			displayModo : OUT STD_LOGIC_VECTOR(0 TO 6)); -- por enquanto mostra o estado (debug)
	
END editor;

ARCHITECTURE logica OF editor IS
SIGNAL Clk : STD_LOGIC;
TYPE STATE_TYPE IS (CLEAR1, CLEAR2, CLEAR3, CLEAR4, IDLE, MSG1, MSG2, sEND);
SIGNAL State : STATE_TYPE := CLEAR1;
SIGNAL Modo : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

	-- altera a frequencia do clock para a desejada (default: 2Hz)
	divisor: clkDivider PORT MAP(Clk50Mhz, Clk);
	d7Modo: sevenSegs PORT MAP(Modo, displayModo);
	
	PROCESS(Clk, Reset)
	BEGIN
		IF Reset = '1' THEN
			State <= CLEAR1;
			
		ELSIF RISING_EDGE(Clk) THEN
			CASE State IS
				WHEN CLEAR1 =>
--					RS <= '0';
--					RW <= '0';
--					Data <= "00000001";
--					En <= '1';
--					Modo <= "0000";
					
					State <= CLEAR2;
					
				WHEN CLEAR2 =>
--					En <= '0';
--					Modo <= "0001";
					
					State <= CLEAR3;
					
				WHEN CLEAR3 =>
--					Data <= "00001110";
--					En <= '1';
--					Modo <= "0010";
					
					State <= CLEAR4;
					
				WHEN CLEAR4 =>
--					En <= '0';
--					Modo <= "0011";
					
					State <= IDLE;
					
				WHEN IDLE => -- ainda nao funcionando como IDLE
--					RS <= '0';
--					RW <= '0';
--					Data <= (OTHERS => '0');
--					Modo <= "0100";
					
					State <= MSG1;
					
				WHEN MSG1 =>
--					RS <= '1';
--					Data <= x"41";
--					En <= '1';
--					Modo <= "0101";
					
					State <= MSG2;
					
				WHEN MSG2 => -- por enquanto funciona como IDLE (teste inicial)
--					En <= '0';
--					Modo <="0110";
					
					State <= MSG2;
					
				WHEN OTHERS =>
--					Modo <= "1111";
					State <= CLEAR1;
			END CASE;
		END IF;
	END PROCESS;
	
	PROCESS(Clk)
	BEGIN
		IF RISING_EDGE(Clk) THEN
			CASE State IS
				WHEN CLEAR1 =>
					RS <= '0';
					RW <= '0';
					Data <= "00000001";
					En <= '1';
					Modo <= "0000";
				
				WHEN CLEAR2 =>
					En <= '0';
					Modo <= "0001";
				
				WHEN CLEAR3 =>
					Data <= "00001110";
					En <= '1';
					Modo <= "0010";
				
				WHEN CLEAR4 =>
					En <= '0';
					Modo <= "0011";
				
				WHEN IDLE =>
					RS <= '0';
					RW <= '0';
					Data <= (OTHERS => '0');
					Modo <= "0100";
				
				WHEN MSG1 =>
					RS <= '1';
					Data <= x"41";
					En <= '1';
					Modo <= "0101";
				
				WHEN MSG2 =>
					En <= '0';
					Modo <="0110";
					
				WHEN OTHERS =>
					Modo <= "1111";
				
			END CASE;
				
		END IF;
	END PROCESS;

END logica;