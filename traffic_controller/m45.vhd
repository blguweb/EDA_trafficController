library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity m45 is
port(
		CLK : in std_logic;
		EN  : in std_logic;
		CR  : in std_logic;
		aQL,aQH,bQL,bQH : out std_logic_vector(3 downto 0)
		);
end m45;

architecture behav of m45 is
	signal acouL,acouH,bcouL,bcouH: std_logic_vector(3 downto 0);
	signal atempL,atempH,btempH,btempL: std_logic_vector(3 downto 0);
	type state_type is (s0,s1,s2,s3);
	signal current_state :state_type;
begin
	process(CR,CLK,EN)
	begin
		if CR='0'then
			acouL<="0000";
			acouH<="0000";
			bcouL<="0000";
			bcouH<="0000";
			current_state <= s0;
		elsif clk'event and clk='1'then
			if EN='1' then
				if acouL="1111" then
					acouL<=atempL;
					acouH<=atempH;
					bcouL<=btempL;
					bcouH<=btempH;
				end if;
				if ( acouL=0 and acouH=0 and bcouH=0 and bcouL=0)then
					acouL<="0000";
					acouH<="0100";
					bcouL<="0101";
					bcouH<="0100";
				elsif (acouL=1 and acouH=0 and current_state=s0) then
					current_state<=s1;
					acouL<="0101";
					acouH<="0000";
					bcouL<=bcouL-1;
				elsif (acouL=1 and acouH=0 and current_state=s1) then
					acouL<="0101";
					acouH<="0100";
					bcouL<="0000";
					bcouH<="0100";
					current_state<=s2;
				elsif (bcouL=1 and bcouH=0 and current_state=s2) then
					bcouL<="0101";
					bcouH<="0000";
					current_state<=s3;
					acouL<=acouL-1;
				elsif (bcouL=1 and bcouH=0 and current_state=s3) then
					acouL<="0000";
					acouH<="0100";
					bcouL<="0101";
					bcouH<="0100";
					current_state<=s0;
				else
					if acouL=0 then
						acouL<="1001";
						acouH<=acouH-1;
					else
						acouL<=acouL-1;
					end if;
					if bcouL=0 then
						bcouL<="1001";
						bcouH<=bcouH-1;
					else
						bcouL<=bcouL-1;
					end if;
				end if;
				atempL<=acouL-1;
				atempH<=acouH;
				btempL<=bcouL-1;
				btempH<=bcouH;
			else
				if acouL="1111" then
					acouL<=atempL;
					acouH<=atempH;
					bcouL<=btempL;
					bcouH<=btempH;
				else
					acouL<="1111";
					acouH<="1111";
					bcouL<="1111";
					bcouH<="1111";
				end if;
			end if;
		end if;
	end process;
	aQL<=acouL;
	aQH<=acouH;
	bQH<=bcouH;
	bQL<=bcouL;
end behav;
