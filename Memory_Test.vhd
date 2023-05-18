LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Memory_Test is
port (
			address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			clk 	  : in std_logic;
			WE		  : in std_logic;
			reset   : in std_logic;
			port_in00,port_in01, port_in02, port_in03: in std_logic_vector (7 downto 0);
			port_out0, port_out1, port_out2, port_out3 : out std_logic_vector(7 downto 0);
			Display0,Display1,Display2,Display3: out std_logic_vector (6 downto 0)
			);
			
end entity;

architecture Memory_Test_arch of Memory_Test is

	component Memory is
			port (
			address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			clk 	  : in std_logic;
			WE		  : in std_logic;
			reset   : in std_logic;
			port_in00,port_in01, port_in02, port_in03: in std_logic_vector (7 downto 0);
			port_out0, port_out1, port_out2, port_out3 : out std_logic_vector(7 downto 0);
			data_out_mux: out std_logic_vector (7 downto 0)
				);
	end component;
			
	component DecodificadorBCD_Hexadecimal is
	port (
				bcd : in  STD_LOGIC_VECTOR (3 downto 0);
				hex : out STD_LOGIC_VECTOR (6 downto 0));
				  
	end component;		


signal data_out_mux 	: std_logic_vector(7 downto 0);
signal data_out_low  : std_logic_vector(3 downto 0):= data_out_mux(3 downto 0);
signal data_out_alto : std_logic_vector(3 downto 0):= data_out_mux(7 downto 4);

signal add_low 		: std_logic_vector(3 downto 0):=address(3 downto 0);
signal add_alta		: std_logic_vector(3 downto 0):=address(7 downto 4);

begin 

D1: DecodificadorBCD_Hexadecimal port map (add_alta,display1);
D2: DecodificadorBCD_Hexadecimal port map (add_low,display0);
D3: Memory  							port map (address,data_in,clk,WE,reset,port_in00,port_in01, port_in02, port_in03,port_out0, port_out1, port_out2, port_out3,data_out_mux);
D4: DecodificadorBCD_Hexadecimal port map (data_out_low,display2);
D5: DecodificadorBCD_Hexadecimal port map (data_out_alto,display3);

end architecture;										 