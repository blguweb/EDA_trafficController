library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity devide is
port(
	clk : in std_logic;
	clk_out: out std_logic
	);
end devide;

architecture arc_devide of devide is
	signal count: std_logic_vector(25 downto 0);
begin
	process
	begin
		wait until clk'event and clk='1';
			if(count<50000000) then
				count<=count+1;
				clk_out<='0';
			else
				count<=(others=>'0');
				clk_out<='1';
			end if;
	end process;
end architecture arc_devide;
