 
LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
ENTITY GEN_FREC IS  
PORT  
( 
  CLK    : IN STD_LOGIC; 
  F_BASE    : IN INTEGER; 
  FREC_OUT  : OUT STD_LOGIC 
   
); 
END GEN_FREC; 
 
 
ARCHITECTURE BEHAVIORAL OF GEN_FREC IS 
 
SIGNAL COUNT1  : INTEGER := 0; 
SIGNAL CLK2    : STD_LOGIC:='0'; 
 
BEGIN 
 
PROCESS (CLK) 
BEGIN 
 
  IF CLK'EVENT AND CLK ='1' THEN 
    
    IF COUNT1 >= F_BASE THEN 
     COUNT1<=0; 
     CLK2<=NOT CLK2; 
    ELSE 
     COUNT1<=COUNT1+1; 
    END IF;
    END IF; 
END PROCESS; 
 
FREC_OUT<=CLK2; 
 
END BEHAVIORAL;