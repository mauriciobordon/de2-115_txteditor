LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.editorTools_package.all;

ENTITY editor IS
	PORT (Clk50Mhz : IN STD_LOGIC;
			Reset : IN STD_LOGIC;
			wrt, spc, inc, dec : IN STD_LOGIC;
			En, RS, RW : OUT STD_LOGIC;
			Data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			displayModo : OUT STD_LOGIC_VECTOR(0 TO 6)); -- por enquanto mostra o estado (debug)
	
END editor;

ARCHITECTURE logica OF editor IS
SIGNAL Clk : STD_LOGIC;
TYPE STATE_TYPE IS (CLEAR1, CLEAR2, CLEAR3, CLEAR4, IDLE, WRITE1, WRITE2, SHOW1, SHOW2, SHOW3, SHOW4, WRITE0);
SIGNAL State : STATE_TYPE := CLEAR1;
SIGNAL Modo : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL DataAux : STD_LOGIC_VECTOR(7 DOWNTO 0);
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
--					Data <= "00001111";
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
					
					State <= WRITE1;
					
				WHEN WRITE1 =>
--					RS <= '1';
--					Data <= x"41";
--					En <= '1';
--					Modo <= "0101";
					
					IF wrt = '0' AND spc = '0' THEN
						State <= WRITE2;
					
					ELSE
						State <= WRITE1;
					
					END IF;
					
				WHEN WRITE2 =>
--					RS <= '1';
--					En <= '0';
--					Modo <= "0110";
					
					State <= SHOW1;
					
				WHEN SHOW1 =>
--					RS <= '0';
--					DataAux <= Data;
--					Modo <= "0111";
					
					State <= SHOW2;
					
				WHEN Show2 =>
--					Data <= "00011000";
--					En <= '1';
--					Modo <= "1000";
					
					State <= SHOW3;
					
				WHEN SHOW3 =>
--					En <= '0';
--					RS <= '1';
--					Modo <= "1001";
					
					IF wrt = '1' THEN
--						Data <= DataAux;
						
						State <= SHOW4;
					
					ELSIF spc = '1' THEN
--						Data <= x"20";
						
						State <= SHOW4;
					
					ELSIF inc = '1' THEN
--						Data <= STD_LOGIC_VECTOR(UNSIGNED(DataAux) + 1);

						State <= SHOW4;
--					
					ELSIF dec = '1' THEN
--						Data <= STD_LOGIC_VECTOR(UNSIGNED(DataAux) - 1);

						State <= SHOW4;
					
					ELSE
						State <= SHOW3;

					END IF;
					
				WHEN SHOW4 =>
--					En <= '1';
--					Modo <= "1010";
					
					IF wrt = '1' OR spc = '1' THEN
						State <= WRITE0;
						
					ELSIF inc = '0' AND dec = '0' THEN					
						State <= WRITE2;
					
					ELSE
						State <= SHOW4;
						
					END IF;
					
				WHEN WRITE0 =>
--					En <= '0';
--					Modo <= "1011";
					
					State <= WRITE1;
					
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
					
				WHEN WRITE1 =>
					RS <= '1';
					Data <= x"41";
					En <= '1';
					Modo <= "0101";
				
				WHEN WRITE2 =>
					RS <= '1';
					En <= '0';
					Modo <= "0110";
				
				WHEN SHOW1 =>
					DataAux <= Data;
					Modo <= "0111";
				
				WHEN SHOW2 =>
					RS <= '0';
					Data <= "00010000";
					En <= '1';
					Modo <= "1000";
				
				WHEN SHOW3 =>
					En <= '0';
					RS <= '1';
					Modo <= "1001";
					
					IF wrt = '1' THEN
						Data <= DataAux;
						
					ELSIF spc = '1' THEN
						Data <= x"20";
					
					ELSIF inc = '1' THEN
						Data <= STD_LOGIC_VECTOR(UNSIGNED(DataAux) + 1);
					
					ELSIF dec = '1' THEN
						Data <= STD_LOGIC_VECTOR(UNSIGNED(DataAux) - 1);
						
					END IF;
					
				WHEN SHOW4  =>
					En <= '1';
					Modo <= "1010";
					
				WHEN WRITE0 =>
					En <= '0';
					Modo <= "1011";
					
				WHEN OTHERS =>
					Modo <= "1111";
				
			END CASE;
				
		END IF;
	END PROCESS;

END logica;