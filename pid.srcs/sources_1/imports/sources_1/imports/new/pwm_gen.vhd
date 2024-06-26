----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2024 17:54:28
-- Design Name: 
-- Module Name: pwm_gen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_gen is
Generic (
    FREC : integer range 1000 to 2500:= 1000; --Valor de la frecuencia FREC : integer range 1000 to 4800:= 4800;
    SIZE: integer range 1 to 16:=16 --tamanio en bits  SIZE: integer range 8 to 16:=13
);
Port (
    CLK : in STD_LOGIC; --reloj de la placa
    RESET : in STD_LOGIC; --reset negado as�ncrono
    DUTY : INTEGER; --salida del PID
    --PWM_H, PWM_L : out STD_LOGIC;
    PWM_OUT : out STD_LOGIC  
 );
end pwm_gen;

architecture Behavioral of pwm_gen is

signal counter : unsigned(SIZE-1 downto 0); --contador para generar la senial

begin

process(CLK,RESET)
begin
    if RESET = '0' then --activaci�n de reset y contadores a 0
        counter <= to_unsigned(FREC, SIZE);
    elsif rising_edge(CLK) then
        counter <= counter - 1; --decremento del contador en cada flanco de reloj
        if counter = to_unsigned(0,SIZE) + 1 then --cuando el contador va a terminar la cuenta
            PWM_OUT <= '0';
            counter <= to_unsigned(FREC,SIZE); --vuelve a comenzar la cuenta regresiva 
            --PWM_H <= '1';
            --PWM_L <= '0';
        elsif counter > FREC - DUTY then
            PWM_OUT <= '1'; --se activa PWM_OUT durante el ciclo de trabajo
            --PWM_H <= '1';
            --PWM_L <= '0';              
        else
            PWM_OUT <= '0'; --se desactiva PWM_OUT    
            --PWM_H <= '0';
            --PWM_L <= '0';                   
        end if;
    end if;
end process;



end Behavioral;