LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Memory is
port (
			address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			clk 	  : in std_logic;
			WE		  : in std_logic;
			reset   : in std_logic;
			port_in00,port_in01, port_in02, port_in03: in std_logic_vector (7 downto 0);
			port_out0, port_out1, port_out2, port_out3 : out std_logic_vector(7 downto 0);
			data_out_mux: out std_logic_vector (7 downto 0));
end entity;

architecture Memory_arch of Memory is

		component rom128x8 is
		port (address : in std_logic_vector(7 downto 0);
				data_out : out std_logic_vector (7 downto 0);
				clk : in std_logic);
		end component;
			
		component RAM is 
		port ( 
				 clk    : in  std_logic;
				 address  : in  std_logic_vector(7 downto 0);
				 data_in  : in  std_logic_vector(7 downto 0);
				 WE       : in  std_logic;
				 data_out_ram : out std_logic_vector(7 downto 0));
		end component;
			
		component Output_Ports is 
		port (
				address : in std_logic_vector(7 downto 0);
				data_in : in std_logic_vector(7 downto 0);
				WE		  : in std_logic;
				clk	  : in std_logic;
				reset   : in std_logic;
				port_out0, port_out1, port_out2, port_out3 : out std_logic_vector(7 downto 0));
		end component;


signal data_out_ram	: std_logic_vector(7 downto 0);
signal data_out 		: std_logic_vector(7 downto 0);


begin 

A0: rom128x8 	  port map (address,data_out,clk);
A1: RAM      	  port map (clk,address,data_in,WE,data_out_ram);
A2: Output_Ports port map (address,data_in,WE,clk,reset,port_out0, port_out1, port_out2, port_out3);

MUX1 : process (address, data_out, data_out_ram, port_in00, port_in01, port_in02, port_in03)

		begin
		if ( (to_integer(unsigned(address)) >= 0) and
		(to_integer(unsigned(address)) <= 127)) then
		data_out_mux <= data_out;
		elsif ( (to_integer(unsigned(address)) >= 128) and
		(to_integer(unsigned(address)) <= 223)) then
		data_out_mux <= data_out_ram;
		elsif (address = x"F0") then data_out_mux <= port_in00;
		elsif (address = x"F1") then data_out_mux <= port_in01;
		elsif (address = x"F2") then data_out_mux <= port_in02;
		elsif (address = x"F3") then data_out_mux <= port_in03;
		else data_out_mux <= x"00";
		end if;	 
		end process;

end architecture;										 