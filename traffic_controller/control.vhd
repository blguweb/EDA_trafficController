library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control is
	port( clk,hold,CR : in std_logic;
		ared,agreen,ayellow,bred,bgreen,byellow : out std_logic);
	end control;

architecture behavior of control is
	type state_type is (s0,s1,s2,s3,s4);
	signal current_state,next_state : state_type;
	signal counter : std_logic_vector(6 downto 0);
	
begin
synch : process
begin
	wait until clk'event and clk ='1';
		if CR = '0' then
			counter<=(others=>'0');
		else
			if hold = '0' then
				counter<=counter;
				
			else
				if counter <=89 then
					counter<=counter+1;
				else
					counter<=(others=>'0');
				end if;
			end if;
		end if;
	end process;

process
begin
	wait until clk'event and clk ='1';
	current_state<=next_state;
end process;

state_trans:process(current_state)
begin
	if CR = '1' then
	case current_state is
	when s0=>
		if hold = '0' then
			next_state<=s4;
		else
			if counter<=39 then
				next_state<=s0;
			else
				next_state<=s1;
			end if;
		end if;
	when s1=>
		if hold = '0' then
			next_state<=s4;
		else
			if counter<=44 then
				next_state<=s1;
			else
				next_state<=s2;
			end if;
		end if;
	when s2=>
		if hold = '0' then
			next_state<=s4;
		else
			if counter<=84 then
				next_state<=s2;
			else
				next_state<=s3;
			end if;
		end if;
	when s3=>
		if hold = '0' then
			next_state<=s4;
		else
			if counter<=89 then
				next_state<=s3;
			else
				next_state<=s0;
			end if;
		end if;
	when s4 =>
		if hold = '0' then
			next_state<=s4;
		else
			if counter<=39 then
				next_state<=s0;
			elsif counter<=44 then
				next_state<=s1;
			elsif counter<=84 then
				next_state<=s2;
			elsif counter<=89 then
				next_state<=s3;
			end if;
		end if;
	end case;
	else
		next_state<=s4;
	end if;
end process;

output: process(current_state)
begin
case current_state is
when s0=>
	ared<='0';
	agreen<='1';
	ayellow<='0';
	bred<='1';
	bgreen<='0';
	byellow<='0';
when s1=>
	ared<='0';
	agreen<='0';
	ayellow<='1';
	bred<='1';
	bgreen<='0';
	byellow<='0';
when s2=>
	ared<='1';
	agreen<='0';
	ayellow<='0';
	bred<='0';
	bgreen<='1';
	byellow<='0';
when s3=>
	ared<='1';
	agreen<='0';
	ayellow<='0';
	bred<='0';
	bgreen<='0';
	byellow<='1';
when s4=>
	ared<='1';
	bred<='1';
	agreen<='0';
	ayellow<='0';
	bgreen<='0';
	byellow<='0';
end case;
end process;
end behavior;