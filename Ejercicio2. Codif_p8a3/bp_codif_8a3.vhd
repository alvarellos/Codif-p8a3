
-- Banco de pruebas del codificador 8:3 con prioridad
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_codif_P8a3 is
	constant MAX_COMB : integer := 256; -- Num. combinac. entrada (2**8)
	constant DELAY    : time := 10 ns;  -- Retardo usado en el test
end entity bp_codif_P8a3;


architecture bp_codif_P8a3 of bp_codif_P8a3 is
-- Salidas UUT
	signal activo : std_logic;
	signal codigo : std_logic_vector(2 downto 0);
-- Entradas UUT
	signal x : std_logic_vector(7 downto 0);

	component codif_P8a3 is
		port ( codigo : out std_logic_vector(2 downto 0);
		       activo : out std_logic;
		       x      : in std_logic_vector(7 downto 0) );
	end component codif_P8a3;


begin -- Cuerpo de la arquitectura
	UUT : component codif_P8a3 port map (codigo,activo,x);
	
	main : process is

	variable esperado_activo : std_logic;
	variable esperado_codigo : std_logic_vector(2 downto 0);
	variable error_count     : integer := 0;

	begin
		report "Comienza la simulacion";

		-- Generar todos los posibles valores de entrada
		for i in 0 to (MAX_COMB-1) loop
			x <= std_logic_vector(TO_UNSIGNED(i,8));
		
		-- Calcular el valor esperado
			if (i=0) then
				esperado_activo := '0';
				esperado_codigo := "000";
			else
				esperado_activo := '1';
				if (i=1) then esperado_codigo := "000";
				elsif (i<=3) then esperado_codigo := "001";
				elsif (i<=7) then esperado_codigo := "010";
				elsif (i<=15) then esperado_codigo := "011";
				elsif (i<=31) then esperado_codigo := "100";
				elsif (i<=63) then esperado_codigo := "101";
				elsif (i<=127) then esperado_codigo := "110";
				else esperado_codigo := "111";
				end if;
			end if;

			wait for DELAY; -- Espera y compara con las salidas de UUT
			if ( esperado_activo /= activo ) then
				report "ERROR en la salida valida. Valor esperado: " &
				std_logic'image(esperado_activo) &
				", valor actual: " &
				std_logic'image(activo) &
				" en el instante: " &
				time'image(now);
				error_count := error_count + 1;
			end if;

			if ( esperado_codigo /= codigo ) then
				report "ERROR en la salida codificada. Valor esperado: " &
				std_logic'image(esperado_codigo(2)) &
				std_logic'image(esperado_codigo(1)) &
				std_logic'image(esperado_codigo(0)) &
				", valor actual: " &
				std_logic'image(codigo(2)) &
				std_logic'image(codigo(1)) &
				std_logic'image(codigo(0)) &
				" en el instante: " &
				time'image(now);
				error_count := error_count + 1;
			end if;
		end loop; -- Final del bucle for de posibles valores de entrada

		-- Informe del numero total de errores
		report "Hay " &
		integer'image(error_count) &
		" errores.";
		wait; -- Final de la simulacion

	end process main;

end architecture bp_codif_P8a3;
	
