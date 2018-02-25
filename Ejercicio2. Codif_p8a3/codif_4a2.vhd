library IEEE;
use IEEE.std_logic_1164.all;



entity codif_P4a2 is
        port ( codigo  : out std_logic_vector(1 downto 0);
               activo  : out std_logic;
               x       : in std_logic_vector(3 downto 0) );
end entity codif_P4a2;


architecture codif_P4a2 of codif_P4a2 is

    signal   nx2            : std_logic;
    signal   sO1, sO2, sA1  : std_logic;

-- Declaracion de las clases de los componentes


    component and2 is
        port ( y0     : out std_logic;
               x0, x1 : in std_logic);
    end component and2;

    component not1 is
        port ( y0 : out std_logic;
               x0 : in std_logic );
    end component not1;

    component or2 is
        port ( y0     : out std_logic;
               x0, x1 : in std_logic );
    end component or2;


begin


--with x select
--codigo <= "11" when "1000" | "1001" | "1010" | "1011" | "1100" | "1101" | "1110" | "1111",
--	  "10" when "0100" | "0101" | "0110" | "0111",
--	  "01" when "0010" | "0011",
--	  "00" when others;

--activo <= x(3) or x(2) or x(1) or x(0);

-- Instanciacion y conexion de los componentes

    N1 : component not1 port map (nx2, x(2));
    A1 : component and2 port map (sA1, nx2, x(1));
    O1 : component or2 port map (sO1, x(1), x(0));
    O2 : component or2 port map (sO2, x(2), x(3));
    O3 : component or2 port map (activo, sO1, sO2);
    O4 : component or2 port map (codigo(1), x(2), x(3));
    O5 : component or2 port map (codigo(0), x(3), sA1);

end architecture codif_P4a2;
