-- Ruler 1         2         3         4         5         6         7        --
--****************************************************************************--
--                     PONTIFICIA UNIVERSIDAD JAVERIANA              
--                            Diseño en FPGA
-- 													             
-- Titulo :   Collision_Ctrl
-- Funcionalidad: Control para identificar la collisión del personaje con las
-- paredes del laberinto.                                        
-- Fecha  :   D:25 M:05 Y:2021                       
--****************************************************************************--


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ENTITY Collision_Ctrl IS

	GENERIC(	N				: INTEGER:= 10
				);
		PORT(	
				clk 			: IN		STD_LOGIC;
				rst			: IN		STD_LOGIC;
				Pacman_x		: IN  	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Pacman_y		: IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				Collision   : OUT    STD_LOGIC
			 );

END ENTITY;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ARCHITECTURE Behaviour OF Collision_Ctrl IS

	--	71  ---> 205
   --	372 ---> 74
	CONSTANT anclaSquare_1_x  : INTEGER := 71 - 20;--51;
	CONSTANT anclaSquare_1_y  : INTEGER := 372 - 20;--371;
	
	--	71  ---> 37
   --	173 ---> 147
	CONSTANT anclaSquare_2_x  : INTEGER := 71 - 20;--51;
	CONSTANT anclaSquare_2_y  : INTEGER := 173 - 20;--172;
	
	--	109  ---> 61
   --	283  ---> 37
	CONSTANT anclaSquare_3_x  : INTEGER := 109 - 20;--89;
	CONSTANT anclaSquare_3_y  : INTEGER := 283 - 20;--282;
	
	--	119  ---> 157
   --	57   ---> 54
	CONSTANT anclaSquare_4_x  : INTEGER := 119 - 20;--99;
	CONSTANT anclaSquare_4_y  : INTEGER := 57 - 20;--56;
	
	--	223  ---> 53
   --	111  ---> 157
	CONSTANT anclaSquare_5_x  : INTEGER := 223 - 20;--203;
	CONSTANT anclaSquare_5_y  : INTEGER := 111 - 20;--110;
	
	-----------------------------------------------------------------
	-----------------------------------------------------------------
	
	CONSTANT anclaSquare_6_x  : INTEGER := 350 - 20;--350;
	CONSTANT anclaSquare_6_y  : INTEGER := 372 - 20;--371;
	
	CONSTANT anclaSquare_7_x  : INTEGER := 350 - 20;--350;
	CONSTANT anclaSquare_7_y  : INTEGER := 111 - 20;--110;
	
	CONSTANT anclaSquare_8_x  : INTEGER := 350 - 20;--350;
	CONSTANT anclaSquare_8_y  : INTEGER := 57 - 20;--56;
	
	CONSTANT anclaSquare_9_x  : INTEGER := 457 - 20;--350+107;
	CONSTANT anclaSquare_9_y  : INTEGER := 283 - 20;--282;
	
	CONSTANT anclaSquare_10_x  : INTEGER := 518 - 20;--350+168;
	CONSTANT anclaSquare_10_y  : INTEGER := 173 - 20;--172;
	
	
	SIGNAL   Collision_s     : STD_LOGIC;
	SIGNAL   Pacman_x_s1     : INTEGER;
	SIGNAL   Pacman_y_s1     : INTEGER;

	
BEGIN
	Pacman_x_s1   <= TO_INTEGER(UNSIGNED(Pacman_x));
	Pacman_y_s1 	 <= TO_INTEGER(UNSIGNED(Pacman_y));
	
	
	Collision_s <= '1' WHEN (((Pacman_x_s1 > anclaSquare_1_x) AND (Pacman_x_s1 < (anclaSquare_1_x+(205+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_1_y) AND  (Pacman_y_s1 < (anclaSquare_1_y+74)))) OR
									
									(((Pacman_x_s1 > anclaSquare_2_x) AND (Pacman_x_s1 < (anclaSquare_2_x+(37+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_2_y) AND  (Pacman_y_s1 < (anclaSquare_2_y+(147+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_3_x) AND (Pacman_x_s1 < (anclaSquare_3_x+(61+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_3_y) AND  (Pacman_y_s1 < (anclaSquare_3_y+(37+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_4_x) AND (Pacman_x_s1 < (anclaSquare_4_x+(157+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_4_y) AND  (Pacman_y_s1 < (anclaSquare_4_y+(54+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_5_x) AND (Pacman_x_s1 < (anclaSquare_5_x+(53+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_5_y) AND  (Pacman_y_s1 < (anclaSquare_5_y+(157+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_6_x) AND (Pacman_x_s1 < (anclaSquare_6_x+(205+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_6_y) AND  (Pacman_y_s1 < (anclaSquare_6_y+74)))) OR
									
									(((Pacman_x_s1 > anclaSquare_7_x) AND (Pacman_x_s1 < (anclaSquare_7_x+(53+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_7_y) AND  (Pacman_y_s1 < (anclaSquare_7_y+(157+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_8_x) AND (Pacman_x_s1 < (anclaSquare_8_x+(157+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_8_y) AND  (Pacman_y_s1 < (anclaSquare_8_y+(54+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_9_x) AND (Pacman_x_s1 < (anclaSquare_9_x+(61+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_9_y) AND  (Pacman_y_s1 < (anclaSquare_9_y+(37+20)))))  OR
									
									(((Pacman_x_s1 > anclaSquare_10_x) AND (Pacman_x_s1 < (anclaSquare_10_x+(37+20))) ) AND 
								   ((Pacman_y_s1 > anclaSquare_10_y) AND  (Pacman_y_s1 < (anclaSquare_10_y+(147+20))))) 
									
									ELSE 
	            '0';
	
	Collision <= Collision_s;
END ARCHITECTURE;