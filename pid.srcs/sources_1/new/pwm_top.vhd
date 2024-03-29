----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.02.2024 19:58:07
-- Design Name: 
-- Module Name: pwm_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_top is
Generic(
    Frecuencies: integer range 1000 to 2500 := 1000;
    PWM_SIZE: integer range 10 to 15 := 13
);
  Port ( 
    CLK : in std_logic;
    RESET : in std_logic;
    Duty : in std_logic_vector(PWM_SIZE-1 DOWNTO 0);
    A, B, C : in std_logic;
    PWM_AH,PWM_BH,PWM_CH: out std_logic;
    PWM_AL,PWM_BL,PWM_CL: out std_logic;
    PWM_HIGH    : out std_logic;
    PWM_LOW     : out std_logic;
    ERROR      : out std_logic
);
end pwm_top;

architecture Behavioral of pwm_top is
COMPONENT pwm_decod
Generic(
    DELAY: integer range 4 to 10 := 4
);
Port(
    CLK : in std_logic;
	RESET : in std_logic;
    A, B, C : in std_logic;
    PWM_IN_H, PWM_IN_L : in std_logic;
    PWM_AH,PWM_BH,PWM_CH: out std_logic;
    PWM_AL,PWM_BL,PWM_CL: out std_logic;
    PWM_H,PWM_L : out std_logic;
    ERROR : out std_logic
);
END COMPONENT;

COMPONENT pwm_gen
Generic (
    FREC : integer range 1000 to 2500 := 1000; --Valor de la frecuencia
    SIZE: integer range 10 to 15 := 13 --tamanio en bits
);
Port (
    CLK : in STD_LOGIC; --reloj de la placa
    RESET : in STD_LOGIC; --reset negado as�ncrono
    PWM_IN : in INTEGER; --salida del PID
    PWM_H, PWM_L : out STD_LOGIC 
 );
END COMPONENT;

signal sig_pwmh,sig_pwml : std_logic;
signal duty_s : integer :=0;

begin

duty_s <= to_integer(unsigned(Duty));

uut_pwm_decod: pwm_decod PORT MAP(
	RESET => RESET,
    A => A,
    B => B,
    C => C,
    CLK => CLK,
    PWM_IN_H => sig_pwmh,
    PWM_IN_L => sig_pwml,
    PWM_AH => PWM_AH,
    PWM_AL => PWM_AL,
    PWM_BH => PWM_BH,
    PWM_BL => PWM_BL,
    PWM_CH => PWM_CH,
    PWM_CL => PWM_CL,
    PWM_H => PWM_HIGH,
    PWM_L => PWM_LOW,
    ERROR => ERROR
);

uut_PWM_Generator: pwm_gen 
GENERIC MAP(
    FREC => Frecuencies,
    SIZE => PWM_SIZE
)
PORT MAP(
  CLK => CLK,
  RESET  => RESET,
  PWM_IN => Duty_s,
  PWM_H => sig_pwmh,
  PWM_L => sig_pwml
);

end Behavioral;
