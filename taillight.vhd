-- 
-- author:   Joey Macauley and Ian Flury
-- file:     taillight.vhdl
-- comments: Implementation of the FSM to dictate the behavior of each signal when the corresponding SW is high. 
--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity taillight is
port ( CLK					: in std_logic; 
	    HZRD, LFT, RGHT  : in std_logic; 
		 RST					: in std_logic; 
		 LIGHTS				: out std_logic_vector(5 downto 0)); 
end taillight;

architecture rtl of taillight is

type state_t is (alloff, allon, allright, allleft, tworight, twoleft, oneright, oneleft); 

signal state, next_state : state_t; 

--signal op : std_logic_vector(2 downto 0); 
--signal reset : std_logic; 
begin	

	machine_p : process(CLK, state)
	begin
   next_state <= alloff; 
	case state is
		when alloff =>
			LIGHTS <= "000000";
			if (HZRD = '1') then
				next_state <= allon; 
			elsif (LFT = '1') then
				next_state <= oneleft;
			elsif (RGHT = '1') then
				next_state <= oneright;
			else
				next_state <= alloff; 
			end if; 
		when allon =>
			LIGHTS <= "111111";
			if (HZRD = '1') then
				next_state <= alloff; 
			elsif (LFT = '1') then
				next_state <= alloff;
			elsif (RGHT = '1') then
				next_state <= alloff;
			else
				next_state <= alloff;
			end if; 
		when allright =>
			LIGHTS <= "000111";
			if (HZRD = '1') then
				next_state <= alloff; 
			elsif (LFT = '1') then
				next_state <= alloff;
			elsif (RGHT = '1') then
				next_state <= alloff;
			else
				next_state <= alloff;
			end if; 
		when allleft =>
			LIGHTS <= "111000";
			if (HZRD = '1') then
				next_state <= alloff; 
			elsif (LFT = '1') then
				next_state <= alloff;
			elsif (RGHT = '1') then
				next_state <= alloff;
			else
				next_state <= alloff;
			end if; 
		when tworight =>
			LIGHTS <= "000110";
			if (HZRD = '1') then
				next_state <= alloff; 
			elsif (LFT = '1') then
				next_state <= alloff;
			elsif (RGHT = '1') then
				next_state <= allright;
			else
				next_state <= alloff;
			end if; 
		when twoleft =>
			LIGHTS <= "011000";
			if (HZRD = '1') then
				next_state <= alloff; 
			elsif (LFT = '1') then
				next_state <= allleft;
			elsif (RGHT = '1') then
				next_state <= alloff;
			else
				next_state <= alloff;
			end if; 	
		when oneright =>
			LIGHTS <= "000100";
			if (HZRD = '1') then
				next_state <= allon; 
			elsif (LFT = '1') then
				next_state <= alloff;
			elsif (RGHT = '1') then
				next_state <= tworight;
			else
				next_state <= alloff;
			end if; 
		when oneleft =>
			LIGHTS <= "001000";
			if (HZRD = '1') then
				next_state <= allon; 
			elsif (LFT = '1') then
				next_state <= twoleft;
			elsif (RGHT = '1') then
				next_state <= alloff;
			else
				next_state <= alloff;
			end if; 
		when others =>
	end case; 
	end process machine_p; 

	register_p : process(RST,CLK)
	begin
		if (RST = '0') then
			state <= alloff; 
		elsif rising_edge(CLK) then
				state <= next_state; 
		else
		end if; 
	end process register_p; 

end rtl;


