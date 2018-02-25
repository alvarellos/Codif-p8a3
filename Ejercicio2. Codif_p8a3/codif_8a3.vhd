library IEEE;
use IEEE.std_logic_1164.all;

entity codif_P8a3 is
        port ( codigo  : out std_logic_vector(2 downto 0);
               activo  : out std_logic;
               x       : in std_logic_vector(7 downto 0) );
end entity codif_P8a3;

architecture codif_P8a3 of codif_P8a3 is

    signal   C1, C2   : std_logic_vector(1 downto 0);
    signal   C1A, C2A : std_logic;
    signal   nA1      : std_logic;
    signal   sA1, sA2 : std_logic;


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

    component codif_P4a2 is
         port ( codigo      : out std_logic_vector(1 downto 0);
                activo      : out std_logic;
                x      : in std_logic_vector(3 downto 0) );
    end component codif_P4a2;


begin

-- Instanciacion y conexion de los componentes

	M1 : component codif_P4a2 port map (C1(1 downto 0), C1A, x(7 downto 4));
        M2 : component codif_P4a2 port map (C2(1 downto 0), C2A, x(3 downto 0));

	N1 : component not1 port map (nA1, C1A);

	A1 : component and2 port map (sA1, nA1, C2(1));
	A2 : component and2 port map (sA2, nA1, C2(0));

	codigo(2) <= C1A;
	O1 : component or2 port map (codigo(1), C1(1), sA1);
	O2 : component or2 port map (codigo(0), C1(0), sA2);

	O3 : component or2 port map (activo, C1A, C2A);

end architecture codif_P8a3;