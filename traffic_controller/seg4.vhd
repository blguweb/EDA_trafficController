library ieee;
use ieee.std_logic_1164.all;

entity seg4 is
port(	datL : in std_logic_vector(3 downto 0);
		datH : in std_logic_vector(3 downto 0);
		aL,bL,cL,dL : out std_logic;
		aH,bH,cH,dH : out std_logic);
end seg4;
architecture arc of seg4 is
begin
	process(datL,datH)
	begin
		aL<=datL(0);
		bL<=datL(1);
		cL<=datL(2);
		dL<=datL(3);
		aH<=datH(0);
		bH<=datH(1);
		cH<=datH(2);
		dH<=datH(3);
	end process;
end arc;
