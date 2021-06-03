-- Ruler 1         2         3         4         5         6         7        --
--****************************************************************************--
--                     PONTIFICIA UNIVERSIDAD JAVERIANA              
--                            Diseño en FPGA
-- 													             
-- Titulo          : FSM_CTRL_Hsync
-- Funcionalidad   : Máquina de estados para el control VGA para Hsync                 
-- Fecha           : D:23 M:04 Y:2021                       
--****************************************************************************--


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ENTITY FSM_CTRL_Hsync IS

		PORT(	
			clk             :  IN  STD_LOGIC; 
			rst             :  IN  STD_LOGIC;
			ready_pix_H     :  IN  STD_LOGIC;
			
			ena_X           :  OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			synClr_X        :  OUT STD_LOGIC;
			hsync           :  OUT STD_LOGIC;
			h_video_on      :  OUT STD_LOGIC;
			end_H           :  OUT STD_LOGIC
			 );

END ENTITY;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ARCHITECTURE Behaviour OF FSM_CTRL_Hsync IS

   --================================================================================
	-- Next state logic
	--================================================================================
	TYPE state IS ( Initial,Retrace_H_96, Left_Bor_H_48, Screen_H_640, Right_Bor_H_16);
						  
	SIGNAL	pr_state, nx_state : state;
	
BEGIN

	lower_fsm: PROCESS (clk, rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state <= Initial;
		ELSIF (rising_edge(clk)) THEN
			pr_state <= nx_state;
		END IF;
	END PROCESS lower_fsm;

	--========================================================
	--Upper part FSM
	--========================================================
	upper_fsm: PROCESS(pr_state, clk,ready_pix_H)
	BEGIN
		CASE pr_state IS
	   ------------------------------------------------------
			WHEN Initial => 
			   ena_X        <= "000";
			   synClr_X     <= '1';
			   hsync        <= '0';
				h_video_on   <= '0';
				End_H        <= '0';

            nx_state <= Retrace_H_96;

			------------------------------------------------------
			WHEN Retrace_H_96 => 
			
			   ena_X        <= "001";
			   synClr_X     <= '0';
			   hsync        <= '0';
				h_video_on   <= '0';
				End_H        <= '0';

				
				IF(ready_pix_H='1') THEN
              nx_state <= Left_Bor_H_48;
            ELSE
				  nx_state <= Retrace_H_96;
            END IF;	
				
			------------------------------------------------------
			WHEN Left_Bor_H_48 => 
			
			   ena_X        <= "010";
			   synClr_X     <= '0';
			   hsync        <= '1';
				h_video_on   <= '0';
				End_H        <= '0';

				
				IF(ready_pix_H='1') THEN
              nx_state <= Screen_H_640;
            ELSE
				  nx_state <= Left_Bor_H_48;
            END IF;
			------------------------------------------------------
			WHEN Screen_H_640 => 
			
			   ena_X        <= "011";
			   synClr_X     <= '0';
			   hsync        <= '1';
				h_video_on   <= '1';
				End_H        <= '0';

				
				IF(ready_pix_H='1') THEN
              nx_state <= Right_Bor_H_16;
            ELSE
				  nx_state <= Screen_H_640;
            END IF;
			------------------------------------------------------
			WHEN Right_Bor_H_16 => 
			
			   ena_X        <= "100";
			   synClr_X     <= '0';
			   hsync        <= '1';
				h_video_on   <= '0';
				End_H        <= '0';

				IF(ready_pix_H='1') THEN
              nx_state <= Initial;
            ELSE
				  nx_state <= Right_Bor_H_16;
            END IF;
	

			------------------------------------------------------
			------------------------------------------------------
			
		END CASE;
	END PROCESS;
	
END ARCHITECTURE;