-- 
-- author:   Joey Macauley and Ian Flury
-- file:     toplevel.vhdl
-- comments: Toplevel file to connect the counter and taillight components.
--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity toplevel is
port (CLK 				 : in std_logic; 
		RST				 : in std_logic; 
		HZRD, LFT, RGHT : in std_logic;
		SLW_CLK 			 : out std_logic;
		LIGHTS			 : out std_logic_vector(5 downto 0));
end toplevel;

architecture rtl of toplevel is

	component taillight is
		port ( CLK					: in std_logic; 
				 RST					: in std_logic; 
				 HZRD, LFT, RGHT  : in std_logic; 
				 LIGHTS				: out std_logic_vector(5 downto 0));
		end component;

	component counter
		port( CLK	 	: in std_logic; 
				CLK_OUT	: out std_logic);
	end component; 
	
	signal slw_clock : std_logic; 

begin 
	
	CLOCK: counter port map (CLK => CLK, CLK_OUT => slw_clock); 
	
	SLW_CLK <= slw_clock; 
	
	TAIL: taillight port map (CLK => slw_clock, RST => RST, HZRD => HZRD, LFT => LFT, RGHT => RGHT, LIGHTS => LIGHTS); 
	
end rtl;