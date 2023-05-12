LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Ram_Test is
port (
			address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			clk : in std_logic;
			WE: in std_logic;
         display0,display1,display2,display3 : out STD_LOGIC_VECTOR (6 downto 0));
			
end Ram_Test;

architecture Ram_Test_arch of Ram_Test is

	component DecodificadorBCD_Hexadecimal is
	port (
				bcd : in  STD_LOGIC_VECTOR (3 downto 0);
				hex : out STD_LOGIC_VECTOR (6 downto 0));
				  
	end component;

	component RAM is 
	port ( 
		 clock  	 : in  std_logic;
       address  : in  std_logic_vector(7 downto 0);
		 data_in  : in  std_logic_vector(7 downto 0);
		 WE       : in  std_logic;
		 data_out : out std_logic_vector(7 downto 0));
 end component;

signal data_out		: std_logic_vector(7 downto 0);
signal add_low 		: std_logic_vector(3 downto 0):=address(3 downto 0);
signal add_alta		: std_logic_vector(3 downto 0):=address(7 downto 4);
signal data_in_bajo : std_logic_vector(3 downto 0):=data_in(3 downto 0);
signal data_in_alto : std_logic_vector(3 downto 0):=data_in(7 downto 4);
signal data_bajo : std_logic_vector(3 downto 0):=data_out(3 downto 0);
signal data_alto : std_logic_vector(3 downto 0):=data_out(7 downto 4);

begin 

D1: DecodificadorBCD_Hexadecimal port map (add_alta,display1);
D2: DecodificadorBCD_Hexadecimal port map (add_low,display0);
D3: RAM 									port map (clk,address,data_in,WE,data_out);
D4: DecodificadorBCD_Hexadecimal port map (data_bajo,display2);
D5: DecodificadorBCD_Hexadecimal port map (data_alto,display3);
end architecture;										 