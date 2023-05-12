LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Rom_Test is
port (
			address : in std_logic_vector(7 downto 0);
			clk : in std_logic;
         display0,display1,display2,display3 : out STD_LOGIC_VECTOR (6 downto 0));
			
end Rom_Test;

architecture rom128x8_arch of Rom_Test is

	component DecodificadorBCD_Hexadecimal is
	port (
				bcd : in  STD_LOGIC_VECTOR (3 downto 0);
				hex : out STD_LOGIC_VECTOR (6 downto 0));
				  
	end component;

	component rom128x8 is
	port (address : in std_logic_vector(7 downto 0);
			data_out : out std_logic_vector (7 downto 0);
			clk : in std_logic);
	end component;

signal data_out		: std_logic_vector(7 downto 0);
signal add_low 		: std_logic_vector(3 downto 0):=address(3 downto 0);
signal add_alta		: std_logic_vector(3 downto 0):=address(7 downto 4);
signal data_out_bajo : std_logic_vector(3 downto 0):=data_out(3 downto 0);
signal data_out_alto : std_logic_vector(3 downto 0):=data_out(7 downto 4);
begin 

D1: DecodificadorBCD_Hexadecimal port map (add_alta,display1);
D2: DecodificadorBCD_Hexadecimal port map (add_low,display0);
D3: rom128x8 							port map (address,data_out,clk);
D4: DecodificadorBCD_Hexadecimal port map (data_out_bajo,display2);
D5: DecodificadorBCD_Hexadecimal port map (data_out_alto,display3);
end architecture;										 